import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class GetExpenseSummary implements UseCase<ExpenseSummary, NoParams> {
  final ManagerRepository repository;

  GetExpenseSummary(this.repository);

  @override
  Future<Result<ExpenseSummary>> call(NoParams params) {
    return repository.getExpenseSummary();
  }
}
