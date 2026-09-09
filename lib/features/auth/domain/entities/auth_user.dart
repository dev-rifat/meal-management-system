import 'package:equatable/equatable.dart';
import 'package:mass_management/core/enums/user_role.dart';

/// Domain-level representation of an authenticated user, decoupled from
/// whatever shape the remote/local data sources happen to return.
class AuthUser extends Equatable {
  final int id;
  final String name;
  final String email;
  final String token;
  final UserRole role;

  /// The mess this user belongs to, or `null` before they've completed the
  /// post-signup create-mess/join-mess step.
  final String? messId;

  final String? phone;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.role,
    this.messId,
    this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, token, role, messId, phone];
}
