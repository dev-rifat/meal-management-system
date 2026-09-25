import 'package:equatable/equatable.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

enum AddMealStatus { initial, loadingMembers, ready, submitting, success, error }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<Member> members;

  /// The logged-in member's own id (resolved by matching their email
  /// against [members]) — used as the submit target when they aren't a
  /// manager, so they can only ever submit for themself.
  final String? myMemberId;

  final String? errorMessage;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.members = const [],
    this.myMemberId,
    this.errorMessage,
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<Member>? members,
    String? myMemberId,
    String? errorMessage,
  }) {
    return AddMealState(
      status: status ?? this.status,
      members: members ?? this.members,
      myMemberId: myMemberId ?? this.myMemberId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, members, myMemberId, errorMessage];
}
