import 'package:equatable/equatable.dart';

/// Domain-level representation of an authenticated user, decoupled from
/// whatever shape the remote/local data sources happen to return.
class AuthUser extends Equatable {
  final int id;
  final String name;
  final String email;
  final String token;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [id, name, email, token];
}
