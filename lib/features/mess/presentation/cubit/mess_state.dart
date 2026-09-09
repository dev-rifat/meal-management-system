import 'package:equatable/equatable.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';

/// States emitted by [MessCubit] while creating or joining a mess.
sealed class MessState extends Equatable {
  const MessState();

  @override
  List<Object?> get props => [];
}

/// Before the sheet has submitted anything.
class MessInitial extends MessState {
  const MessInitial();
}

/// The create/join request is in flight.
class MessSubmitting extends MessState {
  const MessSubmitting();
}

/// Created or joined successfully — the caller can now attach [mess] to
/// the account (sign-up) or the current session (attach-mess gate).
class MessReady extends MessState {
  final Mess mess;

  const MessReady(this.mess);

  @override
  List<Object?> get props => [mess];
}

/// The request failed (e.g. an unknown invite code) — the sheet stays
/// open so the user can retry.
class MessFailure extends MessState {
  final String message;

  const MessFailure(this.message);

  @override
  List<Object?> get props => [message];
}
