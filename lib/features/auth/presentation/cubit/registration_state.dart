import 'package:equatable/equatable.dart';

/// States for the two email-verification steps of registration
/// (start -> code sent -> verified). The final step (create the account)
/// goes through `AuthBloc.FinishRegistrationRequested` instead, since only
/// that one produces a real, app-wide authenticated session.
sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

class RegistrationSubmitting extends RegistrationState {
  const RegistrationSubmitting();
}

/// A verification code has been emailed — [accountRequestId] is needed to
/// verify it next.
class RegistrationCodeSent extends RegistrationState {
  final String accountRequestId;

  const RegistrationCodeSent(this.accountRequestId);

  @override
  List<Object?> get props => [accountRequestId];
}

/// The code was correct — [registrationToken] is needed to finish creating
/// the account (via `AuthBloc`).
class RegistrationVerified extends RegistrationState {
  final String registrationToken;

  const RegistrationVerified(this.registrationToken);

  @override
  List<Object?> get props => [registrationToken];
}

class RegistrationFailure extends RegistrationState {
  final String message;

  const RegistrationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
