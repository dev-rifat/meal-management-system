import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/core/network/serverpod_client.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';

/// Talks to the real backend (Serverpod) for everything auth-related.
/// Registration is verify-by-email, so this also fetches [MessMember] via
/// the same shared [Client] the mess feature uses — "who is the current
/// user" inherently includes "which mess are they in," and that's a single
/// round trip to the same server, not a dependency on the mess feature's
/// own repository layer.
abstract class AuthRemoteDataSource {
  Future<AuthSuccess> login({required String email, required String password});

  Future<String> startRegistration({required String email});

  Future<String> verifyRegistrationCode({
    required String accountRequestId,
    required String verificationCode,
  });

  Future<AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  });

  /// Sets the display name on the freshly created account.
  Future<void> setFullName(String fullName);

  /// The current session's profile (name/email), or `null` if there's no
  /// active session.
  Future<UserProfileModel?> getCurrentProfile();

  /// The current session's mess membership (role/phone/messId), or `null`
  /// if they haven't created/joined a mess yet.
  Future<MessMember?> getCurrentMembership();

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;
  final PersistentAuthKeyManager authKeyManager;

  AuthRemoteDataSourceImpl({required this.client, required this.authKeyManager});

  @override
  Future<AuthSuccess> login({
    required String email,
    required String password,
  }) => _run(() async {
    final auth = await client.emailIdp.login(email: email, password: password);
    await authKeyManager.put(auth.token);
    return auth;
  });

  @override
  Future<String> startRegistration({required String email}) => _run(
    () async => (await client.emailIdp.startRegistration(email: email)).toString(),
  );

  @override
  Future<String> verifyRegistrationCode({
    required String accountRequestId,
    required String verificationCode,
  }) => _run(
    () => client.emailIdp.verifyRegistrationCode(
      accountRequestId: UuidValue.fromString(accountRequestId),
      verificationCode: verificationCode,
    ),
  );

  @override
  Future<AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => _run(() async {
    final auth = await client.emailIdp.finishRegistration(
      registrationToken: registrationToken,
      password: password,
    );
    await authKeyManager.put(auth.token);
    return auth;
  });

  @override
  Future<void> setFullName(String fullName) =>
      _run(() => client.userProfile.changeFullName(fullName));

  @override
  Future<UserProfileModel?> getCurrentProfile() async {
    if (await authKeyManager.get() == null) return null;
    try {
      return await client.userProfile.get();
    } on ServerpodClientException {
      // Stale/expired token — treat as logged out rather than erroring.
      await authKeyManager.remove();
      return null;
    }
  }

  @override
  Future<MessMember?> getCurrentMembership() {
    return _run(() => client.mess.currentMembership());
  }

  @override
  Future<void> logout() => authKeyManager.remove();

  /// Runs a Serverpod client call, translating its typed exceptions into
  /// this app's own exception types so `guard()` (core/error/result.dart)
  /// can map them to a [Failure] the same way every other repository does.
  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on EmailAccountLoginException catch (e) {
      throw UnauthenticatedException(switch (e.reason) {
        EmailAccountLoginExceptionReason.invalidCredentials =>
          'Incorrect email or password.',
        EmailAccountLoginExceptionReason.tooManyAttempts =>
          'Too many attempts — try again later.',
        _ => 'Could not log in.',
      });
    } on AuthUserBlockedException {
      throw const UnauthenticatedException('This account has been blocked.');
    } on EmailAccountRequestException catch (e) {
      throw ServerException(switch (e.reason) {
        EmailAccountRequestExceptionReason.expired =>
          'That code has expired — request a new one.',
        EmailAccountRequestExceptionReason.invalid => 'Invalid or incorrect code.',
        EmailAccountRequestExceptionReason.policyViolation =>
          'Password does not meet the required strength.',
        EmailAccountRequestExceptionReason.tooManyAttempts =>
          'Too many attempts — try again later.',
        _ => 'Could not complete registration.',
      });
    } on ServerpodClientException catch (e) {
      throw NetworkException('Could not reach the server (${e.statusCode}).');
    }
  }
}
