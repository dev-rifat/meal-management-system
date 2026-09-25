import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';

/// Contract the data layer must fulfil for anything auth-related. The
/// presentation layer (via the use cases) only ever talks to this interface.
///
/// Registration is three steps (the server's built-in email identity
/// provider requires verifying an emailed code before an account exists):
/// [startRegistration] -> [verifyRegistrationCode] -> [finishRegistration].
/// Attaching a mess to the resulting account is a separate, later step
/// handled by `MessRepository` — see `mess_choice_sheet.dart` /
/// `user_info_sheet.dart` for how the pieces chain together.
abstract class AuthRepository {
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  });

  /// Starts registration for [email] and emails a verification code.
  /// Returns an account-request id, used to complete the next two steps.
  Future<Result<String>> startRegistration({required String email});

  /// Verifies [code] against [accountRequestId]. Returns a registration
  /// token, used to finish creating the account.
  Future<Result<String>> verifyRegistrationCode({
    required String accountRequestId,
    required String code,
  });

  /// Creates the account and signs the user in.
  Future<Result<AuthUser>> finishRegistration({
    required String registrationToken,
    required String password,
    required String fullName,
  });

  Future<Result<void>> logout();

  /// Returns the currently signed-in user, or `null` if there is no active
  /// session.
  Future<Result<AuthUser?>> getCurrentSession();
}
