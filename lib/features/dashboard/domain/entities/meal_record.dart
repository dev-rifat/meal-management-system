import 'package:equatable/equatable.dart';

enum MealStatus { pending, approved, rejected }

extension MealStatusLabel on MealStatus {
  String get label => switch (this) {
        MealStatus.pending => 'Pending',
        MealStatus.approved => 'Approved',
        MealStatus.rejected => 'Rejected',
      };
}

/// A single day's meal entry. Carries a stable [id] so presentation code
/// can update the right record after filtering, instead of relying on a
/// position within whatever filtered list happens to be on screen.
class MealRecord extends Equatable {
  final String id;
  final DateTime date;
  final double breakfast;
  final double lunch;
  final double dinner;
  final MealStatus status;

  const MealRecord({
    required this.id,
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.status,
  });

  double get total => breakfast + lunch + dinner;

  MealRecord copyWith({MealStatus? status}) => MealRecord(
        id: id,
        date: date,
        breakfast: breakfast,
        lunch: lunch,
        dinner: dinner,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [id, date, breakfast, lunch, dinner, status];
}
