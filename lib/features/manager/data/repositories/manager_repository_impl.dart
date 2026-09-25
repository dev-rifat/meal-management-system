import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/manager/data/datasources/manager_remote_data_source.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final ManagerRemoteDataSource remoteDataSource;
  final MembersRepository membersRepository;

  ManagerRepositoryImpl({
    required this.remoteDataSource,
    required this.membersRepository,
  });

  @override
  Future<Result<List<Expense>>> getExpenses({
    String query = '',
    ExpenseType? filter,
  }) => guard(() => remoteDataSource.getExpenses(query: query, filter: filter));

  @override
  Future<Result<ExpenseSummary>> getExpenseSummary() => guard(() async {
    final expenses = await remoteDataSource.getExpenses();
    final members = await membersRepository
        .getMembers()
        .then((result) => result.fold((f) => throw StateError(f.message), (m) => m));

    final totalCost = expenses.fold<double>(0, (sum, expense) => sum + expense.amount);
    final marketTotal = expenses
        .where((expense) => expense.type == ExpenseType.market)
        .fold<double>(0, (sum, expense) => sum + expense.amount);
    final shareTotal = expenses
        .where((expense) => expense.type == ExpenseType.share)
        .fold<double>(0, (sum, expense) => sum + expense.amount);

    final foodPercentage = totalCost == 0 ? 0.0 : (marketTotal / totalCost) * 100;
    final sharePercentage = totalCost == 0 ? 0.0 : (shareTotal / totalCost) * 100;
    final remainingPercentage = (100 - foodPercentage - sharePercentage).clamp(0, 100).toDouble();

    return ExpenseSummary(
      membersCount: members.length,
      // No income/payment source exists yet, so balance mirrors totalCost —
      // same relationship the old hardcoded literals had, just computed
      // from real expenses now.
      totalCost: totalCost,
      balance: totalCost,
      foodExpensePercentage: foodPercentage,
      sharedExpensePercentage: sharePercentage,
      remainingPercentage: remainingPercentage,
    );
  });

  @override
  Future<Result<Expense>> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
  }) => guard(
    () => remoteDataSource.addExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: spentByMemberId,
    ),
  );

  @override
  Future<Result<Expense>> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
    required String billType,
  }) => guard(
    () => remoteDataSource.addSharedExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: spentByMemberId,
      billType: billType,
    ),
  );

  @override
  Future<Result<List<String>>> getBillTypes() =>
      guard(() => remoteDataSource.getBillTypes());
}
