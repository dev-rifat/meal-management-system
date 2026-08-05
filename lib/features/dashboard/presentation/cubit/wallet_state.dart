import 'package:equatable/equatable.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final BalanceSummary summary;
  final List<Transaction> transactions;

  const WalletLoaded({required this.summary, required this.transactions});

  @override
  List<Object?> get props => [summary, transactions];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}
