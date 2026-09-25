import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class UpdateMealStatusParams extends Equatable {
  final List<String> entryIds;
  final MealStatus status;

  const UpdateMealStatusParams({required this.entryIds, required this.status});

  @override
  List<Object?> get props => [entryIds, status];
}

/// Updates every entry behind a [MealRecord] row — never by its position
/// within a (possibly filtered) list.
class UpdateMealStatusUseCase implements UseCase<void, UpdateMealStatusParams> {
  final DashboardRepository repository;

  const UpdateMealStatusUseCase(this.repository);

  @override
  Future<Result<void>> call(UpdateMealStatusParams params) {
    return repository.updateMealStatus(
      entryIds: params.entryIds,
      status: params.status,
    );
  }
}
