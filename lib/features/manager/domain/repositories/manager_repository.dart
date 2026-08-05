import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';
import 'package:mass_management/features/manager/domain/entities/manager_meal_entry.dart';

/// Single source of truth for the manager feature's data. Backed today by an
/// in-memory local data source (no backend exists yet for mess-management
/// data) — every method below still goes through a real query/mutation
/// instead of being a no-op.
abstract class ManagerRepository {
  Future<Result<List<Expense>>> getExpenses({String query = '', ExpenseType? filter});

  Future<Result<ExpenseSummary>> getExpenseSummary();

  Future<Result<Expense>> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
  });

  Future<Result<Expense>> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
    required String billType,
  });

  Future<Result<List<String>>> getBillTypes();

  Future<Result<List<String>>> addCustomBillType(String billType);

  /// This feature's OWN seeded member-name list (used by the spent-by /
  /// submitted-for dropdowns) — not a cross-feature call to members/user_list.
  Future<Result<List<String>>> getMembersForDropdown();

  Future<Result<ManagerMealEntry>> addMealEntry({
    required DateTime date,
    required Map<String, double> mealCounts,
    required String submittedFor,
    required String role,
  });
}
