import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/usecases/add_meal_entry.dart';
import 'package:mass_management/features/manager/domain/usecases/get_members_for_dropdown.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_state.dart';

/// Backs [AddMeal] — loads this feature's own seeded member list (the
/// dropdown that used to live inline as a `// Dummy user list` widget field)
/// and wires the submit button to a real [AddMealEntry] use case instead of
/// a debugPrint-only no-op.
class AddMealCubit extends Cubit<AddMealState> {
  final AddMealEntry addMealEntry;
  final GetMembersForDropdown getMembersForDropdown;

  AddMealCubit({
    required this.addMealEntry,
    required this.getMembersForDropdown,
  }) : super(const AddMealState());

  Future<void> loadMembers() async {
    emit(state.copyWith(status: AddMealStatus.loadingMembers));
    final result = await getMembersForDropdown(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure.message,
      )),
      (members) => emit(state.copyWith(
        status: AddMealStatus.ready,
        members: members,
      )),
    );
  }

  Future<void> submit({
    required DateTime date,
    required Map<String, double> mealCounts,
    required String submittedFor,
    required String role,
  }) async {
    emit(state.copyWith(status: AddMealStatus.submitting));
    final result = await addMealEntry(AddMealEntryParams(
      date: date,
      mealCounts: mealCounts,
      submittedFor: submittedFor,
      role: role,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: AddMealStatus.success)),
    );
  }
}
