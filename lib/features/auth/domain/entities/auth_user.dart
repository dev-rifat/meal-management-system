import 'package:equatable/equatable.dart';
import 'package:mass_management/core/enums/user_role.dart';

/// Domain-level representation of an authenticated user, decoupled from
/// whatever shape the remote data source happens to return. The session
/// token itself isn't carried here — it's managed separately by
/// `PersistentAuthKeyManager` and attached to every server request
/// automatically, so nothing in the app needs to read it directly.
class AuthUser extends Equatable {
  /// The Serverpod AuthUser id (a UUID, as a string).
  final String id;
  final String name;
  final String email;
  final UserRole role;

  /// The mess this user belongs to, or `null` before they've completed the
  /// post-signup create-mess/join-mess step.
  final String? messId;

  final String? phone;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.messId,
    this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, role, messId, phone];
}
