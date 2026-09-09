import 'package:equatable/equatable.dart';
import 'package:mass_management/core/enums/user_role.dart';

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

class SignUpRequested extends AuthEvent {
  final String email;
  final String username;
  final String phone;
  final String password;
  final UserRole role;
  final String messId;

  const SignUpRequested({
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
    required this.role,
    required this.messId,
  });

  @override
  List<Object?> get props => [email, username, phone, password, role, messId];
}

/// Attaches a mess to an already-authenticated session that somehow has
/// none — the normal sign-up path attaches it at registration instead.
class AttachMessRequested extends AuthEvent {
  final String messId;
  final UserRole role;

  const AttachMessRequested({required this.messId, required this.role});

  @override
  List<Object?> get props => [messId, role];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckSessionRequested extends AuthEvent {
  const CheckSessionRequested();
}
