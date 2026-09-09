import 'package:mass_management/core/enums/user_role.dart';
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
    required String phone,
    required String password,
    required UserRole role,
    required String messId,
  });

  Future<Result<void>> logout();

  /// Returns the currently signed-in user, or `null` if there is no active
  /// session.
  Future<Result<AuthUser?>> getCurrentSession();

  /// Attaches the current session to [messId] and sets its final [role]
  /// (manager if they created the mess, member if they joined one). Used
  /// only for an already-authenticated session that somehow has no mess
  /// yet — sign-up itself now attaches the mess at registration time.
  Future<Result<AuthUser>> attachMess({
    required String messId,
    required UserRole role,
  });
}
