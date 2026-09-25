import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';

/// Single source of truth for the manager feature's expense data — backed
/// by the real server (`ExpenseEndpoint`). The "who spent it" member
/// picker is the members feature's `GetMembers`, not owned here.
abstract class ManagerRepository {
  Future<Result<List<Expense>>> getExpenses({String query = '', ExpenseType? filter});

  Future<Result<ExpenseSummary>> getExpenseSummary();

  Future<Result<Expense>> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
  });

  Future<Result<Expense>> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
    required String billType,
  });

  Future<Result<List<String>>> getBillTypes();
}
