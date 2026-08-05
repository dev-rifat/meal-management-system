import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/usecases/add_custom_bill_type.dart';
import 'package:mass_management/features/manager/domain/usecases/add_shared_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_bill_types.dart';
import 'package:mass_management/features/manager/domain/usecases/get_members_for_dropdown.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_state.dart';

/// Backs [AddShareExpenseScreen] — loads the member list + bill types,
/// persists newly-added custom bill types through [AddCustomBillType]
/// instead of local-only widget state, and wires the submit button to
/// [AddSharedExpense] instead of a debugPrint-only no-op.
class AddShareExpenseCubit extends Cubit<AddShareExpenseState> {
  final AddSharedExpense addSharedExpense;
  final AddCustomBillType addCustomBillType;
  final GetBillTypes getBillTypes;
  final GetMembersForDropdown getMembersForDropdown;

  AddShareExpenseCubit({
    required this.addSharedExpense,
    required this.addCustomBillType,
    required this.getBillTypes,
    required this.getMembersForDropdown,
  }) : super(const AddShareExpenseState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(status: AddShareExpenseStatus.loading));

    final membersResult = await getMembersForDropdown(const NoParams());
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

  Future<void> addBillType(String billType) async {
    final result = await addCustomBillType(AddCustomBillTypeParams(billType));
    result.fold(
      (failure) => emit(state.copyWith(
        status: AddShareExpenseStatus.error,
        errorMessage: failure.message,
      )),
      (billTypes) => emit(state.copyWith(
        status: AddShareExpenseStatus.ready,
        billTypes: billTypes,
      )),
    );
  }

  Future<void> submit({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
    required String billType,
  }) async {
    emit(state.copyWith(status: AddShareExpenseStatus.submitting));
    final result = await addSharedExpense(AddSharedExpenseParams(
      title: title,
      amount: amount,
      date: date,
      details: details,
      spentBy: spentBy,
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
