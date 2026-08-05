import 'package:equatable/equatable.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final List<BalanceSummary> balanceSummaries;
  final int selectedBalanceIndex;
  final List<Transaction> transactions;

  const DashboardLoaded({
    required this.balanceSummaries,
    required this.selectedBalanceIndex,
    required this.transactions,
  });

  BalanceSummary get selectedBalance => balanceSummaries[selectedBalanceIndex];

  DashboardLoaded copyWith({int? selectedBalanceIndex}) => DashboardLoaded(
        balanceSummaries: balanceSummaries,
        selectedBalanceIndex: selectedBalanceIndex ?? this.selectedBalanceIndex,
        transactions: transactions,
      );

  @override
  List<Object?> get props => [balanceSummaries, selectedBalanceIndex, transactions];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
