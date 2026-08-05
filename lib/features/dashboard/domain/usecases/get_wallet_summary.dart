import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

/// The balance summary shown at the top of the wallet screen.
class GetWalletSummaryUseCase implements UseCase<BalanceSummary, NoParams> {
  final DashboardRepository repository;

  const GetWalletSummaryUseCase(this.repository);

  @override
  Future<Result<BalanceSummary>> call(NoParams params) {
    return repository.getWalletSummary();
  }
}
