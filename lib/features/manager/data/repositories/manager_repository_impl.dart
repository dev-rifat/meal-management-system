import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/manager/data/datasources/manager_local_data_source.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';
import 'package:mass_management/features/manager/domain/entities/manager_meal_entry.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final ManagerLocalDataSource localDataSource;

  ManagerRepositoryImpl(this.localDataSource);

  @override
  Future<Result<List<Expense>>> getExpenses({String query = '', ExpenseType? filter}) async {
    return ResultSuccess(localDataSource.getExpenses(query: query, filter: filter));
  }

  @override
  Future<Result<ExpenseSummary>> getExpenseSummary() async {
    final expenses = localDataSource.allExpenses;

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

    return ResultSuccess(
      ExpenseSummary(
        membersCount: localDataSource.getMembersCount(),
        // No income/payment source exists yet, so balance mirrors totalCost —
        // same relationship the old hardcoded literals had, just computed now.
        totalCost: totalCost,
        balance: totalCost,
        foodExpensePercentage: foodPercentage,
        sharedExpensePercentage: sharePercentage,
        remainingPercentage: remainingPercentage,
      ),
    );
  }

  @override
  Future<Result<Expense>> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
  }) async {
    return ResultSuccess(localDataSource.addExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentBy: spentBy,
    ));
  }

  @override
  Future<Result<Expense>> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
    required String billType,
  }) async {
    return ResultSuccess(localDataSource.addSharedExpense(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentBy: spentBy,
      billType: billType,
    ));
  }

  @override
  Future<Result<List<String>>> getBillTypes() async {
    return ResultSuccess(localDataSource.getBillTypes());
  }

  @override
  Future<Result<List<String>>> addCustomBillType(String billType) async {
    return ResultSuccess(localDataSource.addCustomBillType(billType));
  }

  @override
  Future<Result<List<String>>> getMembersForDropdown() async {
    return ResultSuccess(localDataSource.getMembersForDropdown());
  }

  @override
  Future<Result<ManagerMealEntry>> addMealEntry({
    required DateTime date,
    required Map<String, double> mealCounts,
    required String submittedFor,
    required String role,
  }) async {
    return ResultSuccess(localDataSource.addMealEntry(
      date: date,
      mealCounts: mealCounts,
      submittedFor: submittedFor,
      role: role,
    ));
  }
}
