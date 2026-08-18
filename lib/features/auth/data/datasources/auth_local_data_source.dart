import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';

/// Purely in-memory session/registration store. There is no persistence
/// package (e.g. shared_preferences) wired into this project yet, so the
/// current session and any "registered" users are lost on app restart —
/// an accepted limitation for this pass. Do not add a new dependency to
/// work around it here; that belongs to a dedicated persistence pass.
abstract class AuthLocalDataSource {
  AuthUser? get currentUser;

  void saveSession(AuthUser user);

  void clearSession();

  /// Registers a new user in-memory (so sign-up can "succeed") and signs
  /// them in immediately, already attached to [messId] — the mess choice
  /// is made before sign-up now, not after.
  AuthUser registerUser({
    required String email,
    required String username,
    required String password,
    required UserRole role,
    required String messId,
  });

  /// The role chosen at signup for [email], or [UserRole.member] if this
  /// email never signed up through this app (e.g. a pre-existing demo
  /// login account) — there is no real backend to ask instead.
  UserRole roleForEmail(String email);

  /// The mess [email] last attached to via [attachMess], or `null` if they
  /// haven't completed that step yet this session.
  String? messIdForEmail(String email);

  /// Updates the current session's role and mess once the post-signup
  /// create-mess/join-mess step completes.
  AuthUser attachMess({required String messId, required UserRole role});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthUser? _currentUser;
  final Map<String, String> _registeredUsers =
      <String, String>{}; // email -> password
  final Map<String, UserRole> _emailRoles = <String, UserRole>{};
  final Map<String, String> _emailMessIds = <String, String>{};
  int _nextId = 1000;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  void saveSession(AuthUser user) {
    _currentUser = user;
  }

  @override
  void clearSession() {
    _currentUser = null;
  }

  @override
  UserRole roleForEmail(String email) => _emailRoles[email] ?? UserRole.member;

  @override
  String? messIdForEmail(String email) => _emailMessIds[email];

  @override
  AuthUser attachMess({required String messId, required UserRole role}) {
    final current = _currentUser;
    if (current == null) {
      throw const UnauthenticatedException();
    }
    _emailRoles[current.email] = role;
    _emailMessIds[current.email] = messId;
    final updated = AuthUser(
      id: current.id,
      name: current.name,
      email: current.email,
      token: current.token,
      role: role,
      messId: messId,
    );
    _currentUser = updated;
    return updated;
  }

  @override
  AuthUser registerUser({
    required String email,
    required String username,
    required String password,
    required UserRole role,
    required String messId,
  }) {
    if (_registeredUsers.containsKey(email)) {
      throw const ServerException('An account with this email already exists.');
    }

    _registeredUsers[email] = password;
    _emailRoles[email] = role;
    _emailMessIds[email] = messId;

    final user = AuthUser(
      id: _nextId++,
      name: username,
      email: email,
      token: 'local-session-$email',
      role: role,
      messId: messId,
    );
    _currentUser = user;
    return user;
  }
}
