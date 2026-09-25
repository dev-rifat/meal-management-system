import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/usecases/add_shared_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_bill_types.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_state.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';

/// Backs [AddShareExpenseScreen] — loads the mess's real member list and
/// existing bill types, and wires the submit button to [AddSharedExpense].
///
/// A newly typed bill type is only added to the dropdown locally: the
/// server has no standalone "create bill type" endpoint, it only
/// find-or-creates one by name inline when [addSharedExpense] is called.
class AddShareExpenseCubit extends Cubit<AddShareExpenseState> {
  final AddSharedExpense addSharedExpense;
  final GetBillTypes getBillTypes;
  final GetMembers getMembers;

  AddShareExpenseCubit({
    required this.addSharedExpense,
    required this.getBillTypes,
    required this.getMembers,
  }) : super(const AddShareExpenseState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(status: AddShareExpenseStatus.loading));

    final membersResult = await getMembers(const GetMembersParams());
    final billTypesResult = await getBillTypes(const NoParams());

    membersResult.fold(
      (failure) => emit(state.copyWith(
        status: AddShareExpenseStatus.error,
        errorMessage: failure.message,
      )),
      (members) {
        billTypesResult.fold(
          (failure) => emit(state.copyWith(
            status: AddShareExpenseStatus.error,
            errorMessage: failure.message,
            members: members,
          )),
          (billTypes) => emit(state.copyWith(
            status: AddShareExpenseStatus.ready,
            members: members,
            billTypes: billTypes,
          )),
        );
      },
    );
  }

  void addBillType(String billType) {
    if (state.billTypes.contains(billType)) return;
    emit(state.copyWith(billTypes: [...state.billTypes, billType]));
  }

  Future<void> submit({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentByMemberId,
    required String billType,
  }) async {
    emit(state.copyWith(status: AddShareExpenseStatus.submitting));
    final result = await addSharedExpense(AddSharedExpenseParams(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentByMemberId: spentByMemberId,
      billType: billType,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddShareExpenseStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: AddShareExpenseStatus.success)),
    );
  }
}
