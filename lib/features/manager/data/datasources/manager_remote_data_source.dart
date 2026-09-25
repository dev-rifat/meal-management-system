import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart' as domain;
import 'package:mess_manager_server_client/mess_manager_server_client.dart' as server;

/// Talks to the real backend's `ExpenseEndpoint`. Server rows carry a
/// `memberId`/`billTypeId`, not display names — this resolves both via
/// `client.mess.members()` and `client.expense.getBillTypes()` (the same
/// calls the members feature and the add-expense form already make) so
/// the domain [domain.Expense] is ready to show directly.
abstract class ManagerRemoteDataSource {
  Future<List<domain.Expense>> getExpenses({
    String query = '',
    domain.ExpenseType? filter,
  });

  Future<domain.Expense> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
  });

  Future<domain.Expense> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
    required String billType,
  });

  Future<List<String>> getBillTypes();
}

class ManagerRemoteDataSourceImpl implements ManagerRemoteDataSource {
  final server.Client client;

  ManagerRemoteDataSourceImpl(this.client);

  @override
  Future<List<domain.Expense>> getExpenses({
    String query = '',
    domain.ExpenseType? filter,
  }) => _run(() async {
    final rows = await client.expense.getExpenses(
      query: query,
      type: filter == null ? null : _toServerType(filter),
    );
    final namesById = await _memberNamesById();
    final billTypeNamesById = await _billTypeNamesById();
    return rows.map((r) => _toDomain(r, namesById, billTypeNamesById)).toList();
  });

  @override
  Future<domain.Expense> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
  }) => _run(() async {
    final row = await client.expense.addExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: int.parse(spentByMemberId),
    );
    final namesById = await _memberNamesById();
    return _toDomain(row, namesById, const {});
  });

  @override
  Future<domain.Expense> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
    required String billType,
  }) => _run(() async {
    final row = await client.expense.addSharedExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: int.parse(spentByMemberId),
      billType: billType,
    );
    final namesById = await _memberNamesById();
    final billTypeNamesById = await _billTypeNamesById();
    return _toDomain(row, namesById, billTypeNamesById);
  });

  @override
  Future<List<String>> getBillTypes() =>
      _run(() async => (await client.expense.getBillTypes()).map((b) => b.name).toList());

  Future<Map<String, String>> _memberNamesById() async {
    final members = await client.mess.members();
    return {for (final m in members) m.id.toString(): m.name};
  }

  Future<Map<String, String>> _billTypeNamesById() async {
    final billTypes = await client.expense.getBillTypes();
    return {for (final b in billTypes) b.id.toString(): b.name};
  }

  domain.Expense _toDomain(
    server.Expense row,
    Map<String, String> namesById,
    Map<String, String> billTypeNamesById,
  ) {
    return domain.Expense(
      id: row.id.toString(),
      title: row.title,
      amount: row.amount,
      type: _toDomainType(row.type),
      date: row.date,
      details: row.details,
      spentBy: namesById[row.memberId.toString()] ?? '',
      billType: row.billTypeId == null
          ? null
          : billTypeNamesById[row.billTypeId.toString()],
    );
  }

  domain.ExpenseType _toDomainType(server.ExpenseType type) => switch (type) {
    server.ExpenseType.market => domain.ExpenseType.market,
    server.ExpenseType.share => domain.ExpenseType.share,
  };

  server.ExpenseType _toServerType(domain.ExpenseType type) => switch (type) {
    domain.ExpenseType.market => server.ExpenseType.market,
    domain.ExpenseType.share => server.ExpenseType.share,
  };

  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on server.MessMemberNotFoundException {
      throw const NotFoundException('Member not found.');
    } on server.NotMessManagerException {
      throw const UnauthenticatedException(
        'Only the mess manager can do that.',
      );
    } on server.ServerpodClientException catch (e) {
      throw NetworkException('Could not reach the server (${e.statusCode}).');
    }
  }
}
