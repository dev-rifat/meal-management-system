import 'package:equatable/equatable.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

enum AddShareExpenseStatus { initial, loading, ready, submitting, success, error }

class AddShareExpenseState extends Equatable {
  final AddShareExpenseStatus status;
  final List<Member> members;
  final List<String> billTypes;
  final String? errorMessage;

  const AddShareExpenseState({
    this.status = AddShareExpenseStatus.initial,
    this.members = const [],
    this.billTypes = const [],
    this.errorMessage,
  });

  AddShareExpenseState copyWith({
    AddShareExpenseStatus? status,
    List<Member>? members,
    List<String>? billTypes,
    String? errorMessage,
  }) {
    return AddShareExpenseState(
      status: status ?? this.status,
      members: members ?? this.members,
      billTypes: billTypes ?? this.billTypes,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, members, billTypes, errorMessage];
}
