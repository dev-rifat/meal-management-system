import 'package:intl/intl.dart';
import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart' as server;

/// Talks to the real backend for everything dashboard-related: meals (via
/// `MealEndpoint`) and the financial figures — balance cards, wallet,
/// transactions, monthly summary — via `DashboardEndpoint`'s computed
/// aggregates (see that endpoint's doc comment for how "meal rate" and
/// each figure is derived; nothing here is stored, all of it is summed
/// from [server.Payment]/[server.Expense]/[server.MealEntry] rows).
abstract class DashboardRemoteDataSource {
  Future<List<MealRecord>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  });

  Future<void> updateMealStatus({
    required List<String> entryIds,
    required MealStatus status,
  });

  Future<void> submit({
    required String memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  });

  /// The mess-wide (current month) and the caller's own personal balance
  /// cards, in that order — matching `BalanceCardSwitcher`'s indexing.
  Future<List<BalanceSummary>> getBalanceSummaries();

  Future<BalanceSummary> getWalletSummary();

  Future<List<Transaction>> getTransactions();

  Future<MonthlySummaryResult> getMonthlySummary({DateTime? monthAnchor});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final server.Client client;

  DashboardRemoteDataSourceImpl(this.client);

  @override
  Future<List<MealRecord>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  }) => _run(() async {
    final entries = await client.meal.getMealsForMonth(month: month);
    final members = await client.mess.members();
    final namesById = {for (final m in members) m.id.toString(): m.name};

    final grouped = <String, List<server.MealEntry>>{};
    for (final entry in entries) {
      final key = '${entry.memberId}-${entry.date.toIso8601String()}';
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    final records = grouped.entries.map((group) {
      final rows = group.value;
      final first = rows.first;
      double forType(server.MealType type) => rows
          .where((r) => r.mealType == type)
          .fold(0.0, (sum, r) => sum + r.mealCount);
      final rolledUpStatus = rows.any((r) => r.status == server.MealStatus.pending)
          ? MealStatus.pending
          : rows.any((r) => r.status == server.MealStatus.rejected)
              ? MealStatus.rejected
              : MealStatus.approved;
      return MealRecord(
        id: group.key,
        memberId: first.memberId.toString(),
        memberName: namesById[first.memberId.toString()] ?? '',
        date: first.date,
        breakfast: forType(server.MealType.breakfast),
        lunch: forType(server.MealType.lunch),
        dinner: forType(server.MealType.dinner),
        status: rolledUpStatus,
        entryIds: rows.map((r) => r.id!.toString()).toList(),
      );
    }).toList();

    records.sort((a, b) => a.date.compareTo(b.date));
    if (status == null) return records;
    return records.where((r) => r.status == status).toList();
  });

  @override
  Future<void> updateMealStatus({
    required List<String> entryIds,
    required MealStatus status,
  }) => _run(() async {
    final serverStatus = switch (status) {
      MealStatus.pending => server.MealStatus.pending,
      MealStatus.approved => server.MealStatus.approved,
      MealStatus.rejected => server.MealStatus.rejected,
    };
    for (final id in entryIds) {
      await client.meal.updateStatus(
        mealEntryId: int.parse(id),
        status: serverStatus,
      );
    }
  });

  @override
  Future<void> submit({
    required String memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  }) => _run(
    () => client.meal.submit(
      memberId: int.parse(memberId),
      date: date,
      mealCounts: mealCounts,
    ),
  );

  @override
  Future<List<BalanceSummary>> getBalanceSummaries() => _run(() async {
    final mess = await client.dashboard.getMessSummary();
    final member = await client.dashboard.getMemberSummary();
    return [
      BalanceSummary(
        label: DateFormat('MMMM yyyy').format(DateTime.now()),
        mealRate: mess.mealRate,
        deposit: mess.deposit,
        expense: mess.expense,
      ),
      BalanceSummary(
        label: 'Personal Balance',
        balance: member.balance,
        deposit: member.deposit,
        expense: member.expense,
      ),
    ];
  });

  @override
  Future<BalanceSummary> getWalletSummary() => _run(() async {
    final member = await client.dashboard.getMemberSummary();
    return BalanceSummary(
      label: 'My Wallet',
      balance: member.balance,
      mealRate: member.mealRate,
      deposit: member.deposit,
      expense: member.expense,
    );
  });

  @override
  Future<List<Transaction>> getTransactions() => _run(() async {
    final records = await client.dashboard.getTransactions();
    return records.map(_toTransaction).toList();
  });

  @override
  Future<MonthlySummaryResult> getMonthlySummary({DateTime? monthAnchor}) => _run(() async {
    final result = await client.dashboard.getMonthlySummary(month: monthAnchor ?? DateTime.now());
    return MonthlySummaryResult(
      totalCost: result.totalCost,
      totalMeal: result.totalMeal,
      members: result.members
          .map((m) => MonthlySummaryEntry(
                name: m.name,
                totalMeal: m.totalMeal,
                totalCost: m.totalCost,
                paid: m.paid,
              ))
          .toList(),
    );
  });

  Transaction _toTransaction(server.TransactionRecord record) {
    final title = switch (record.type) {
      server.TransactionType.deposit => 'Deposit',
      server.TransactionType.marketExpense => record.label ?? 'Market Expense',
      server.TransactionType.sharedExpense => record.label ?? 'Shared Expense',
    };
    return Transaction(title: title, date: record.date, amount: record.amount);
  }

  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on server.MealEntryNotFoundException {
      throw const NotFoundException('Meal entry not found.');
    } on server.MessMemberNotFoundException {
      throw const NotFoundException('Not in a mess yet.');
    } on server.NotMessManagerException {
      throw const UnauthenticatedException(
        'Only the mess manager can do that.',
      );
    } on server.ServerpodClientException catch (e) {
      throw NetworkException('Could not reach the server (${e.statusCode}).');
    }
  }
}
