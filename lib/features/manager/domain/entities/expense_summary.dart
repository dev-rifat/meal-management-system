import 'package:equatable/equatable.dart';

/// Aggregate numbers shown on the manager dashboard: the summary cards and
/// the pie-chart breakdown. Computed from this feature's own expense data
/// rather than hardcoded literals.
class ExpenseSummary extends Equatable {
  /// Demo-seeded member count for the "Members" summary card. Intentionally
  /// not derived from any member list or cross-feature source — see the
  /// manager feature notes on why this stays a local seeded value.
  final int membersCount;

  final double totalCost;
  final double balance;

  /// Percentage breakdown for the pie chart. These three always sum to 100.
  final double foodExpensePercentage;
  final double sharedExpensePercentage;
  final double remainingPercentage;

  const ExpenseSummary({
    required this.membersCount,
    required this.totalCost,
    required this.balance,
    required this.foodExpensePercentage,
    required this.sharedExpensePercentage,
    required this.remainingPercentage,
  });

  @override
  List<Object?> get props => [
        membersCount,
        totalCost,
        balance,
        foodExpensePercentage,
        sharedExpensePercentage,
        remainingPercentage,
      ];
}
