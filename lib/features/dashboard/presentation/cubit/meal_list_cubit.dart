import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_meals_for_month.dart';
import 'package:mass_management/features/dashboard/domain/usecases/update_meal_status.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/meal_list_state.dart';

/// Drives the meal list screen. Filters (month + status) are applied via
/// [GetMealsForMonthUseCase] and status updates via
/// [UpdateMealStatusUseCase] — both keyed by [MealRecord.id], never by a
/// position within the currently-filtered list, which is what caused the
/// old widget to occasionally mutate the wrong record.
class MealListCubit extends Cubit<MealListState> {
  final GetMealsForMonthUseCase getMealsForMonth;
  final UpdateMealStatusUseCase updateMealStatusUseCase;

  MealListCubit({
    required this.getMealsForMonth,
    required this.updateMealStatusUseCase,
  }) : super(const MealListLoading());

  MonthFilter _monthFilter = MonthFilter.thisMonth;
  DateTime? _customDate;
  MealStatus? _statusFilter;

  Future<void> load() => _fetch();

  Future<void> changeMonthFilter(MonthFilter filter, {DateTime? customDate}) {
    _monthFilter = filter;
    if (customDate != null) _customDate = customDate;
    return _fetch();
  }

  Future<void> changeStatusFilter(MealStatus? status) {
    _statusFilter = status;
    return _fetch();
  }

  Future<void> updateStatus(List<String> entryIds, MealStatus status) async {
    final result = await updateMealStatusUseCase(
      UpdateMealStatusParams(entryIds: entryIds, status: status),
    );
    result.fold(
      (failure) {
        emit(MealListError(failure.message));
      },
      (_) {
        _fetch();
      },
    );
  }

  Future<void> _fetch() async {
    emit(const MealListLoading());
    final result = await getMealsForMonth(
      GetMealsForMonthParams(month: _resolveMonth(), status: _statusFilter),
    );
    result.fold(
      (failure) {
        emit(MealListError(failure.message));
      },
      (meals) {
        emit(MealListLoaded(
          meals: meals,
          monthFilter: _monthFilter,
          customDate: _customDate,
          statusFilter: _statusFilter,
        ));
      },
    );
  }

  DateTime _resolveMonth() {
    final now = DateTime.now();
    switch (_monthFilter) {
      case MonthFilter.thisMonth:
        return DateTime(now.year, now.month);
      case MonthFilter.lastMonth:
        return DateTime(now.year, now.month - 1);
      case MonthFilter.custom:
        final date = _customDate ?? now;
        return DateTime(date.year, date.month);
    }
  }
}
