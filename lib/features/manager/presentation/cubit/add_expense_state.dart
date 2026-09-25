import 'package:equatable/equatable.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

enum AddExpenseStatus { initial, loadingMembers, ready, submitting, success, error }

class AddExpenseState extends Equatable {
  final AddExpenseStatus status;
  final List<Member> members;
  final String? errorMessage;

  const AddExpenseState({
    this.status = AddExpenseStatus.initial,
    this.members = const [],
    this.errorMessage,
  });

  AddExpenseState copyWith({
    AddExpenseStatus? status,
    List<Member>? members,
    String? errorMessage,
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, members, errorMessage];
}
