import 'package:equatable/equatable.dart';

enum AddMealStatus { initial, loadingMembers, ready, submitting, success, error }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<String> members;
  final String? errorMessage;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.members = const [],
    this.errorMessage,
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<String>? members,
    String? errorMessage,
  }) {
    return AddMealState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, members, errorMessage];
}
