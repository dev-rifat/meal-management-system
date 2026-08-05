import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';

/// Contract the data layer must fulfil for anything auth-related. The
/// presentation layer (via the use cases) only ever talks to this interface.
abstract class AuthRepository {
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthUser>> signUp({
    required String email,
    required String username,
    required String password,
  });

  Future<Result<void>> logout();

  /// Returns the currently signed-in user, or `null` if there is no active
  /// session.
  Future<Result<AuthUser?>> getCurrentSession();
}
