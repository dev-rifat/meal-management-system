import 'package:equatable/equatable.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';

/// Which month the meal list is showing. Mirrors the old "This
/// Month"/"Last Month"/"Custom" dropdown, but as a real value the cubit
/// can resolve to an actual month instead of a label nothing acted on.
enum MonthFilter { thisMonth, lastMonth, custom }

abstract class MealListState extends Equatable {
  const MealListState();

  @override
  List<Object?> get props => [];
}

class MealListLoading extends MealListState {
  const MealListLoading();
}

class MealListLoaded extends MealListState {
  final List<MealRecord> meals;
  final MonthFilter monthFilter;
  final DateTime? customDate;
  final MealStatus? statusFilter;

  const MealListLoaded({
    required this.meals,
    required this.monthFilter,
    required this.customDate,
    required this.statusFilter,
  });

  @override
  List<Object?> get props => [meals, monthFilter, customDate, statusFilter];
}

class MealListError extends MealListState {
  final String message;

  const MealListError(this.message);

  @override
  List<Object?> get props => [message];
}
