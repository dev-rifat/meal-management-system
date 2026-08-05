import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/usecases/add_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_members_for_dropdown.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_state.dart';

/// Backs [AddExpenseScreen] — loads this feature's own seeded member list
/// for the "Spent By" dropdown and wires the submit button to a real
/// [AddExpense] use case instead of a debugPrint-only no-op.
class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpense addExpense;
  final GetMembersForDropdown getMembersForDropdown;

  AddExpenseCubit({
    required this.addExpense,
    required this.getMembersForDropdown,
  }) : super(const AddExpenseState());

  Future<void> loadMembers() async {
    emit(state.copyWith(status: AddExpenseStatus.loadingMembers));
    final result = await getMembersForDropdown(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddExpenseStatus.error,
        errorMessage: failure.message,
      )),
      (members) => emit(state.copyWith(
        status: AddExpenseStatus.ready,
        members: members,
      )),
    );
  }

  Future<void> submit({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
  }) async {
    emit(state.copyWith(status: AddExpenseStatus.submitting));
    final result = await addExpense(AddExpenseParams(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentBy: spentBy,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddExpenseStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: AddExpenseStatus.success)),
    );
  }
}
