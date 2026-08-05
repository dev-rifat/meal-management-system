import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_balance_summaries.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_transactions.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetBalanceSummariesUseCase getBalanceSummaries;
  final GetTransactionsUseCase getTransactions;

  DashboardCubit({
    required this.getBalanceSummaries,
    required this.getTransactions,
  }) : super(const DashboardLoading());

  Future<void> load() async {
    emit(const DashboardLoading());

    final balancesResult = await getBalanceSummaries(const NoParams());
    final transactionsResult = await getTransactions(const NoParams());

    balancesResult.fold(
      (failure) {
        emit(DashboardError(failure.message));
      },
      (balances) {
        transactionsResult.fold(
          (failure) {
            emit(DashboardError(failure.message));
          },
          (transactions) {
            emit(DashboardLoaded(
              balanceSummaries: balances,
              selectedBalanceIndex: 0,
              transactions: transactions,
            ));
          },
        );
      },
    );
  }

  /// Toggles between the mess-wide and personal balance card.
  void toggleBalanceCard() {
    final current = state;
    if (current is DashboardLoaded) {
      final nextIndex = (current.selectedBalanceIndex + 1) % current.balanceSummaries.length;
      emit(current.copyWith(selectedBalanceIndex: nextIndex));
    }
  }
}
