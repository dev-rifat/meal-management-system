import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expenses.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_state.dart';

/// Backs [ExpenseListScreen] — combines the search box text and the
/// Market/Share type filter into a single query through [GetExpenses]. Fixes
/// the previous bug where the search box had no `onChanged` at all and only
/// the type filter actually worked.
class ExpenseListCubit extends Cubit<ExpenseListState> {
  final GetExpenses getExpenses;

  ExpenseListCubit({required this.getExpenses}) : super(const ExpenseListState());

  Future<void> load() => _fetch(query: state.query, filter: state.filter);

  Future<void> search(String query) => _fetch(query: query, filter: state.filter);

  Future<void> filterByType(ExpenseType? type) => _fetch(query: state.query, filter: type);

  Future<void> _fetch({required String query, required ExpenseType? filter}) async {
    emit(ExpenseListState(
      status: ExpenseListStatus.loading,
      expenses: state.expenses,
      query: query,
      filter: filter,
    ));
    final result = await getExpenses(GetExpensesParams(query: query, filter: filter));
    result.fold(
      (failure) => emit(ExpenseListState(
        status: ExpenseListStatus.error,
        expenses: state.expenses,
        query: query,
        filter: filter,
        errorMessage: failure.message,
      )),
      (expenses) => emit(ExpenseListState(
        status: ExpenseListStatus.loaded,
        expenses: expenses,
        query: query,
        filter: filter,
      )),
    );
  }
}
