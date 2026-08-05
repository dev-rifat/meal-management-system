import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class AddExpenseParams {
  final String title;
  final double amount;
  final DateTime date;
  final String details;
  final String spentBy;

  const AddExpenseParams({
    required this.title,
    required this.amount,
    required this.date,
    required this.details,
    required this.spentBy,
  });
}

class AddExpense implements UseCase<Expense, AddExpenseParams> {
  final ManagerRepository repository;

  AddExpense(this.repository);

  @override
  Future<Result<Expense>> call(AddExpenseParams params) {
    return repository.addExpense(
      title: params.title,
      amount: params.amount,
      date: params.date,
      details: params.details,
      spentBy: params.spentBy,
    );
  }
}
