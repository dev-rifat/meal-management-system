import 'package:equatable/equatable.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

sealed class MembersState extends Equatable {
  const MembersState();

  @override
  List<Object?> get props => [];
}

class MembersLoading extends MembersState {
  const MembersLoading();
}

class MembersLoaded extends MembersState {
  final List<Member> members;

  /// The search query that produced [members], kept so a delete/update can
  /// re-run the same filter afterwards instead of resetting it.
  final String query;

  const MembersLoaded(this.members, {this.query = ''});

  @override
  List<Object?> get props => [members, query];
}

class MembersError extends MembersState {
  final String message;

  const MembersError(this.message);

  @override
  List<Object?> get props => [message];
}
