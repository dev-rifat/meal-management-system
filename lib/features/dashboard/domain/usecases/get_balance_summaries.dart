import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

/// The mess-wide and personal balance cards shown on the dashboard.
class GetBalanceSummariesUseCase implements UseCase<List<BalanceSummary>, NoParams> {
  final DashboardRepository repository;

  const GetBalanceSummariesUseCase(this.repository);

  @override
  Future<Result<List<BalanceSummary>>> call(NoParams params) {
    return repository.getBalanceSummaries();
  }
}
