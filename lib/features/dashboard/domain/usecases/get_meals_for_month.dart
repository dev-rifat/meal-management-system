import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetMealsForMonthParams extends Equatable {
  final DateTime month;
  final MealStatus? status;

  const GetMealsForMonthParams({required this.month, this.status});

  @override
  List<Object?> get props => [month, status];
}

class GetMealsForMonthUseCase implements UseCase<List<MealRecord>, GetMealsForMonthParams> {
  final DashboardRepository repository;

  const GetMealsForMonthUseCase(this.repository);

  @override
  Future<Result<List<MealRecord>>> call(GetMealsForMonthParams params) {
    return repository.getMealsForMonth(month: params.month, status: params.status);
  }
}
