import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class GetExpensesParams {
  final String query;
  final ExpenseType? filter;

  const GetExpensesParams({this.query = '', this.filter});
}

class GetExpenses implements UseCase<List<Expense>, GetExpensesParams> {
  final ManagerRepository repository;

  GetExpenses(this.repository);

  @override
  Future<Result<List<Expense>>> call(GetExpensesParams params) {
    return repository.getExpenses(query: params.query, filter: params.filter);
  }
}
