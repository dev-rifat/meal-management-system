import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'mess_authorization.dart';

/// Computed aggregates for the dashboard/wallet/monthly-summary screens —
/// derived from [Payment] (deposits), [Expense] and [MealEntry] rows
/// rather than stored anywhere directly. "Meal rate" throughout means
/// total market (food) expense divided by total *approved* meal count —
/// shared expenses (bills) don't factor into it.
class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _userProfiles = UserProfiles();

  /// The caller's own all-time deposits vs. recorded expenses (both
  /// market and shared expenses they were recorded as the spender of).
  Future<MemberFinancialSummary> getMemberSummary(Session session) async {
    final caller = await session.requireCurrentMembership();

    final deposit = await _sumPayments(session, messId: caller.messId, memberId: caller.id);
    final expense = await _sumExpenses(session, messId: caller.messId, memberId: caller.id);
    final mealRate = await _mealRate(session, messId: caller.messId);

    return MemberFinancialSummary(
      deposit: deposit,
      expense: expense,
      balance: deposit - expense,
      mealRate: mealRate,
    );
  }

  /// The whole mess's deposits/food-expense/meal-rate for [month]
  /// (`null` means the current month).
  Future<MessFinancialSummary> getMessSummary(Session session, {DateTime? month}) async {
    final caller = await session.requireCurrentMembership();
    final range = _MonthRange(month ?? DateTime.now());

    final deposit = await _sumPayments(session, messId: caller.messId, range: range);
    final expense = await _sumExpenses(session, messId: caller.messId, type: ExpenseType.market, range: range);
    final totalMeal = await _totalApprovedMeals(session, messId: caller.messId, range: range);

    return MessFinancialSummary(
      deposit: deposit,
      expense: expense,
      mealRate: totalMeal == 0 ? 0 : expense / totalMeal,
    );
  }

  /// [month]'s mess-wide totals plus the per-member breakdown — each
  /// member's total (approved) meal count, the cost that implies at this
  /// month's meal rate, and what they've paid in over the same month.
  Future<MonthlySummaryResult> getMonthlySummary(Session session, {required DateTime month}) async {
    final caller = await session.requireCurrentMembership();
    final range = _MonthRange(month);

    final mealEntries = await MealEntry.db.find(
      session,
      where: (t) =>
          t.messId.equals(caller.messId) &
          t.date.between(range.start, range.end) &
          t.status.equals(MealStatus.approved),
    );
    final marketExpense = await _sumExpenses(
      session,
      messId: caller.messId,
      type: ExpenseType.market,
      range: range,
    );
    final payments = await Payment.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId) & t.date.between(range.start, range.end),
    );

    final totalMeal = mealEntries.fold(0.0, (sum, e) => sum + e.mealCount);
    final mealRate = totalMeal == 0 ? 0.0 : marketExpense / totalMeal;

    final members = await MessMember.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId),
      orderBy: (t) => t.joiningDate,
    );

    final memberSummaries = <MonthlySummaryMember>[];
    for (final member in members) {
      final memberMeal = mealEntries
          .where((e) => e.memberId == member.id)
          .fold(0.0, (sum, e) => sum + e.mealCount);
      final memberPaid = payments
          .where((p) => p.memberId == member.id)
          .fold(0.0, (sum, p) => sum + p.amount);
      final profile = await _userProfiles.maybeFindUserProfileByUserId(session, member.authUserId);
      memberSummaries.add(
        MonthlySummaryMember(
          memberId: member.id!,
          name: profile?.fullName ?? profile?.userName ?? '',
          totalMeal: memberMeal,
          totalCost: memberMeal * mealRate,
          paid: memberPaid,
        ),
      );
    }

    return MonthlySummaryResult(
      totalCost: marketExpense,
      totalMeal: totalMeal,
      members: memberSummaries,
    );
  }

  /// The caller's own transaction history: their deposits and the
  /// expenses they were recorded as the spender of, newest first.
  Future<List<TransactionRecord>> getTransactions(Session session) async {
    final caller = await session.requireCurrentMembership();

    final payments = await Payment.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId) & t.memberId.equals(caller.id),
    );
    final expenses = await Expense.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId) & t.memberId.equals(caller.id),
    );

    final records = <TransactionRecord>[
      for (final p in payments)
        TransactionRecord(type: TransactionType.deposit, amount: p.amount, date: p.date),
      for (final e in expenses)
        TransactionRecord(
          type: e.type == ExpenseType.market
              ? TransactionType.marketExpense
              : TransactionType.sharedExpense,
          amount: e.amount,
          date: e.date,
          label: e.title,
        ),
    ];
    records.sort((a, b) => b.date.compareTo(a.date));
    return records;
  }

  Future<double> _sumPayments(
    Session session, {
    required int messId,
    int? memberId,
    _MonthRange? range,
  }) async {
    final rows = await Payment.db.find(
      session,
      where: (t) {
        var expr = t.messId.equals(messId);
        if (memberId != null) expr = expr & t.memberId.equals(memberId);
        if (range != null) expr = expr & t.date.between(range.start, range.end);
        return expr;
      },
    );
    return rows.fold<double>(0.0, (sum, p) => sum + p.amount);
  }

  Future<double> _sumExpenses(
    Session session, {
    required int messId,
    int? memberId,
    ExpenseType? type,
    _MonthRange? range,
  }) async {
    final rows = await Expense.db.find(
      session,
      where: (t) {
        var expr = t.messId.equals(messId);
        if (memberId != null) expr = expr & t.memberId.equals(memberId);
        if (type != null) expr = expr & t.type.equals(type);
        if (range != null) expr = expr & t.date.between(range.start, range.end);
        return expr;
      },
    );
    return rows.fold<double>(0.0, (sum, e) => sum + e.amount);
  }

  Future<double> _totalApprovedMeals(
    Session session, {
    required int messId,
    _MonthRange? range,
  }) async {
    final rows = await MealEntry.db.find(
      session,
      where: (t) {
        var expr = t.messId.equals(messId) & t.status.equals(MealStatus.approved);
        if (range != null) expr = expr & t.date.between(range.start, range.end);
        return expr;
      },
    );
    return rows.fold<double>(0.0, (sum, e) => sum + e.mealCount);
  }

  Future<double> _mealRate(Session session, {required int messId}) async {
    final expense = await _sumExpenses(session, messId: messId, type: ExpenseType.market);
    final meals = await _totalApprovedMeals(session, messId: messId);
    return meals == 0 ? 0 : expense / meals;
  }
}

/// `[start, end)` for the calendar month containing [anchor].
class _MonthRange {
  final DateTime start;
  final DateTime end;

  _MonthRange(DateTime anchor)
      : start = DateTime(anchor.year, anchor.month),
        end = DateTime(anchor.year, anchor.month + 1);
}
