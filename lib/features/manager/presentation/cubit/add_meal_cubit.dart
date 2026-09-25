import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/dashboard/domain/usecases/submit_meal.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_state.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';

/// Backs [AddMeal] — loads the mess's real member list (for the manager's
/// picker, and to resolve the caller's own member id by email) and submits
/// through the same `SubmitMealUseCase` the dashboard's meal list reads
/// back from (see `MealEndpoint`/`DashboardRepository.submitMeal`).
class AddMealCubit extends Cubit<AddMealState> {
  final SubmitMealUseCase submitMealUseCase;
  final GetMembers getMembers;

  AddMealCubit({required this.submitMealUseCase, required this.getMembers})
      : super(const AddMealState());

  Future<void> loadMembers(String myEmail) async {
    emit(state.copyWith(status: AddMealStatus.loadingMembers));
    final result = await getMembers(const GetMembersParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure.message,
      )),
      (members) {
        final me = members.where((m) => m.email == myEmail).firstOrNull;
        emit(state.copyWith(
          status: AddMealStatus.ready,
          members: members,
          myMemberId: me?.id,
        ));
      },
    );
  }

  Future<void> submit({
    required String memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  }) async {
    emit(state.copyWith(status: AddMealStatus.submitting));
    final result = await submitMealUseCase(
      SubmitMealParams(memberId: memberId, date: date, mealCounts: mealCounts),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: AddMealStatus.success)),
    );
  }
}
