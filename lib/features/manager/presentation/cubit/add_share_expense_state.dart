import 'package:equatable/equatable.dart';

enum AddShareExpenseStatus { initial, loading, ready, submitting, success, error }

class AddShareExpenseState extends Equatable {
  final AddShareExpenseStatus status;
  final List<String> members;
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
    List<String>? members,
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
