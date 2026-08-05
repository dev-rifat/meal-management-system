import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expense_summary.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_state.dart';

/// Backs [MessManagerPage] — loads the members/cost/balance summary cards
/// and the pie-chart breakdown from the feature's own expense data instead
/// of the hardcoded literals the page used to render.
class ManagerSummaryCubit extends Cubit<ManagerSummaryState> {
  final GetExpenseSummary getExpenseSummary;

  ManagerSummaryCubit({required this.getExpenseSummary}) : super(const ManagerSummaryState());

  Future<void> loadSummary() async {
    emit(state.copyWith(status: ManagerSummaryStatus.loading));
    final result = await getExpenseSummary(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ManagerSummaryStatus.error,
        errorMessage: failure.message,
      )),
      (summary) => emit(state.copyWith(
        status: ManagerSummaryStatus.loaded,
        summary: summary,
      )),
    );
  }
}
