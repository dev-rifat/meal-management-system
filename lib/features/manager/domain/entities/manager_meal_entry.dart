import 'package:equatable/equatable.dart';

/// A single meal submission made from the manager's "Add Meal" screen.
class ManagerMealEntry extends Equatable {
  final DateTime date;

  /// Meal type -> count, e.g. {"Breakfast": 0.5, "Lunch": 1, "Dinner": 1}.
  final Map<String, double> mealCounts;

  /// Name of the member this entry was submitted for.
  final String submittedFor;

  /// "manager" or "member" — mirrors the role that submitted the entry.
  final String role;

  const ManagerMealEntry({
    required this.date,
    required this.mealCounts,
    required this.submittedFor,
    required this.role,
  });

  @override
  List<Object?> get props => [date, mealCounts, submittedFor, role];
}
