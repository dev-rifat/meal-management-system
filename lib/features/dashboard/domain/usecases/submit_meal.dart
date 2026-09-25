import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class SubmitMealParams extends Equatable {
  final String memberId;
  final DateTime date;
  final Map<String, double> mealCounts;

  const SubmitMealParams({
    required this.memberId,
    required this.date,
    required this.mealCounts,
  });

  @override
  List<Object?> get props => [memberId, date, mealCounts];
}

class SubmitMealUseCase implements UseCase<void, SubmitMealParams> {
  final DashboardRepository repository;

  const SubmitMealUseCase(this.repository);

  @override
  Future<Result<void>> call(SubmitMealParams params) {
    return repository.submitMeal(
      memberId: params.memberId,
      date: params.date,
      mealCounts: params.mealCounts,
    );
  }
}
