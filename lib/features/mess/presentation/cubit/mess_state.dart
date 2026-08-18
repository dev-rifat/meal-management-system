import 'package:equatable/equatable.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';

sealed class MessState extends Equatable {
  const MessState();

  @override
  List<Object?> get props => [];
}

class MessInitial extends MessState {
  const MessInitial();
}

class MessSubmitting extends MessState {
  const MessSubmitting();
}

class MessReady extends MessState {
  final Mess mess;

  const MessReady(this.mess);

  @override
  List<Object?> get props => [mess];
}

class MessFailure extends MessState {
  final String message;

  const MessFailure(this.message);

  @override
  List<Object?> get props => [message];
}
