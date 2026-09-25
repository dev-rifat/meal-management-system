import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'mess_authorization.dart';

/// Market and shared expenses — any mess member can read; only a manager
/// can record one.
class ExpenseEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// A market expense, attributed to [spentByMemberId].
  Future<Expense> addExpense(
    Session session, {
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required int spentByMemberId,
  }) async {
    final caller = await session.requireManager();
    final spender = await session.requireMemberInMess(spentByMemberId, caller.messId);

    return Expense.db.insertRow(
      session,
      Expense(
        messId: caller.messId,
        memberId: spender.id!,
        title: title,
        amount: amount,
        type: ExpenseType.market,
        date: date,
        details: details,
      ),
    );
  }

  /// A shared expense under [billType] — finds-or-creates that bill type
  /// by name within the caller's mess.
  Future<Expense> addSharedExpense(
    Session session, {
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required int spentByMemberId,
    required String billType,
  }) async {
    final caller = await session.requireManager();
    final spender = await session.requireMemberInMess(spentByMemberId, caller.messId);
    final billTypeRow = await _findOrCreateBillType(session, caller.messId, billType);

    return Expense.db.insertRow(
      session,
      Expense(
        messId: caller.messId,
        memberId: spender.id!,
        title: title,
        amount: amount,
        type: ExpenseType.share,
        date: date,
        details: details,
        billTypeId: billTypeRow.id,
      ),
    );
  }

  /// Every expense in the caller's mess, optionally filtered by [type] and
  /// a case-insensitive [query] against the title.
  Future<List<Expense>> getExpenses(
    Session session, {
    String query = '',
    ExpenseType? type,
  }) async {
    final caller = await session.requireCurrentMembership();
    final rows = await Expense.db.find(
      session,
      where: (t) {
        var expr = t.messId.equals(caller.messId);
        if (type != null) expr = expr & t.type.equals(type);
        return expr;
      },
      orderBy: (t) => t.date,
      orderDescending: true,
    );
    if (query.trim().isEmpty) return rows;
    final lowerQuery = query.trim().toLowerCase();
    return rows.where((e) => e.title.toLowerCase().contains(lowerQuery)).toList();
  }

  /// Every bill type name defined in the caller's mess.
  /// Every bill type defined in the caller's mess (id+name — the id is
  /// needed to resolve `Expense.billTypeId` back to a name for display).
  Future<List<BillType>> getBillTypes(Session session) async {
    final caller = await session.requireCurrentMembership();
    return BillType.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId),
      orderBy: (t) => t.name,
    );
  }

  Future<BillType> _findOrCreateBillType(
    Session session,
    int messId,
    String name,
  ) async {
    final trimmed = name.trim();
    final existing = await BillType.db.findFirstRow(
      session,
      where: (t) => t.messId.equals(messId) & t.name.equals(trimmed),
    );
    if (existing != null) return existing;
    return BillType.db.insertRow(session, BillType(messId: messId, name: trimmed));
  }
}
