import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Shared by the dashboard screen and the wallet screen — both render the
/// same transaction list, just in a different spot on the page.
class GetTransactionsUseCase implements UseCase<List<Transaction>, NoParams> {
  final DashboardRepository repository;

  const GetTransactionsUseCase(this.repository);

  @override
  Future<Result<List<Transaction>>> call(NoParams params) {
    return repository.getTransactions();
  }
}
