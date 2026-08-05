import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_transactions.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_wallet_summary.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWalletSummaryUseCase getWalletSummary;
  final GetTransactionsUseCase getTransactions;

  WalletCubit({
    required this.getWalletSummary,
    required this.getTransactions,
  }) : super(const WalletLoading());

  Future<void> load() async {
    emit(const WalletLoading());

    final summaryResult = await getWalletSummary(const NoParams());
    final transactionsResult = await getTransactions(const NoParams());

    summaryResult.fold(
      (failure) {
        emit(WalletError(failure.message));
      },
      (summary) {
        transactionsResult.fold(
          (failure) {
            emit(WalletError(failure.message));
          },
          (transactions) {
            emit(WalletLoaded(summary: summary, transactions: transactions));
          },
        );
      },
    );
  }
}
