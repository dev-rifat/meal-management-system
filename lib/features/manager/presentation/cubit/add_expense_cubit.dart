import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/manager/domain/usecases/add_expense.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_state.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';

/// Backs [AddExpenseScreen] — loads the mess's real member list for the
/// "Spent By" dropdown and submits through [AddExpense].
class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpense addExpense;
  final GetMembers getMembers;

  AddExpenseCubit({
    required this.addExpense,
    required this.getMembers,
  }) : super(const AddExpenseState());

  Future<void> loadMembers() async {
    emit(state.copyWith(status: AddExpenseStatus.loadingMembers));
    final result = await getMembers(const GetMembersParams());
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
    required String spentByMemberId,
  }) async {
    emit(state.copyWith(status: AddExpenseStatus.submitting));
    final result = await addExpense(AddExpenseParams(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: spentByMemberId,
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
