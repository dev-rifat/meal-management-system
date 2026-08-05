import 'package:equatable/equatable.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';

enum ExpenseListStatus { initial, loading, loaded, error }

class ExpenseListState extends Equatable {
  final ExpenseListStatus status;
  final List<Expense> expenses;
  final String query;
  final ExpenseType? filter;
  final String? errorMessage;

  const ExpenseListState({
    this.status = ExpenseListStatus.initial,
    this.expenses = const [],
    this.query = '',
    this.filter,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, expenses, query, filter, errorMessage];
}
