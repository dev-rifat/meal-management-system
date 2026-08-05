import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class UpdateMealStatusParams extends Equatable {
  final String id;
  final MealStatus status;

  const UpdateMealStatusParams({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}

/// Updates a meal record by its stable [MealRecord.id] — never by its
/// position within a (possibly filtered) list.
class UpdateMealStatusUseCase implements UseCase<MealRecord, UpdateMealStatusParams> {
  final DashboardRepository repository;

  const UpdateMealStatusUseCase(this.repository);

  @override
  Future<Result<MealRecord>> call(UpdateMealStatusParams params) {
    return repository.updateMealStatus(id: params.id, status: params.status);
  }
}
