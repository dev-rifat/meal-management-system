import 'package:equatable/equatable.dart';

enum AddExpenseStatus { initial, loadingMembers, ready, submitting, success, error }

class AddExpenseState extends Equatable {
  final AddExpenseStatus status;
  final List<String> members;
  final String? errorMessage;

  const AddExpenseState({
    this.status = AddExpenseStatus.initial,
    this.members = const [],
    this.errorMessage,
  });

  AddExpenseState copyWith({
    AddExpenseStatus? status,
    List<String>? members,
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
