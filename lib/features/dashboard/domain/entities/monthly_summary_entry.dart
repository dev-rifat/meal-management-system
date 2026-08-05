import 'package:equatable/equatable.dart';

/// A single mess member's row within the monthly summary.
class MonthlySummaryEntry extends Equatable {
  final String name;
  final int totalMeal;
  final double totalCost;
  final double paid;

  const MonthlySummaryEntry({
    required this.name,
    required this.totalMeal,
    required this.totalCost,
    required this.paid,
  });

  @override
  List<Object?> get props => [name, totalMeal, totalCost, paid];
}

/// Aggregate result for a given month (or custom month range): the
/// mess-wide totals plus the per-member breakdown that together make up
/// the monthly summary screen.
class MonthlySummaryResult extends Equatable {
  final double totalCost;
  final double totalMeal;
  final List<MonthlySummaryEntry> members;

  const MonthlySummaryResult({
    required this.totalCost,
    required this.totalMeal,
    required this.members,
  });

  double get mealRate => totalMeal == 0 ? 0 : totalCost / totalMeal;

  @override
  List<Object?> get props => [totalCost, totalMeal, members];
}
