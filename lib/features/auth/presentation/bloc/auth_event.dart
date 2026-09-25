import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// The final step of registration (after `RegistrationCubit` has walked the
/// email-verification steps) — creates the account and signs the user in.
/// The account has no mess yet; the caller creates/joins one next via
/// `MessCubit`, then re-fires [CheckSessionRequested] to pick up the
/// resulting `messId` (see `mess_choice_sheet.dart`/`user_info_sheet.dart`).
class FinishRegistrationRequested extends AuthEvent {
  final String registrationToken;
  final String password;
  final String fullName;

  const FinishRegistrationRequested({
    required this.registrationToken,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [registrationToken, password, fullName];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckSessionRequested extends AuthEvent {
  const CheckSessionRequested();
}
