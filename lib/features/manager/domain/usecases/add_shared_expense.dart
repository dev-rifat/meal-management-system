import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class AddSharedExpenseParams {
  final String title;
  final double amount;
  final DateTime date;
  final String details;
  final String spentByMemberId;
  final String billType;

  const AddSharedExpenseParams({
    required this.title,
    required this.amount,
    required this.date,
    required this.details,
    required this.spentByMemberId,
    required this.billType,
  });
}

class AddSharedExpense implements UseCase<Expense, AddSharedExpenseParams> {
  final ManagerRepository repository;

  AddSharedExpense(this.repository);

  @override
  Future<Result<Expense>> call(AddSharedExpenseParams params) {
    return repository.addSharedExpense(
      title: params.title,
      amount: params.amount,
      date: params.date,
      details: params.details,
      spentByMemberId: params.spentByMemberId,
      billType: params.billType,
    );
  }
}
