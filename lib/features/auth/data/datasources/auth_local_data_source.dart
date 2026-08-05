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
  /// them in immediately.
  AuthUser registerUser({
    required String email,
    required String username,
    required String password,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthUser? _currentUser;
  final Map<String, String> _registeredUsers = <String, String>{}; // email -> password
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
  AuthUser registerUser({
    required String email,
    required String username,
    required String password,
  }) {
    if (_registeredUsers.containsKey(email)) {
      throw const ServerException('An account with this email already exists.');
    }

    _registeredUsers[email] = password;

    final user = AuthUser(
      id: _nextId++,
      name: username,
      email: email,
      token: 'local-session-$email',
    );
    _currentUser = user;
    return user;
  }
}
