import 'package:equatable/equatable.dart';

enum MealStatus { pending, approved, rejected }

extension MealStatusLabel on MealStatus {
  String get label => switch (this) {
        MealStatus.pending => 'Pending',
        MealStatus.approved => 'Approved',
        MealStatus.rejected => 'Rejected',
      };
}

/// One member's meal totals for one day, built by grouping the server's
/// per-(member, date, meal type) rows — see `DashboardRemoteDataSource`'s
/// doc comment for the grouping/status-rollup rules. [entryIds] carries
/// the underlying row ids so an approve/reject action can update all of
/// them together; [id] is just a stable per-row key for widgets.
class MealRecord extends Equatable {
  final String id;
  final String memberId;
  final String memberName;
  final DateTime date;
  final double breakfast;
  final double lunch;
  final double dinner;
  final MealStatus status;
  final List<String> entryIds;

  const MealRecord({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.status,
    required this.entryIds,
  });

  double get total => breakfast + lunch + dinner;

  @override
  List<Object?> get props => [
        id,
        memberId,
        memberName,
        date,
        breakfast,
        lunch,
        dinner,
        status,
        entryIds,
      ];
}
