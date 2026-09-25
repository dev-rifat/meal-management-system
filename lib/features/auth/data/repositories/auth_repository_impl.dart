import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    hide AuthUser;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  }) => guard(() async {
    await remoteDataSource.login(email: email, password: password);
    return _currentAuthUser();
  });

  @override
  Future<Result<String>> startRegistration({required String email}) =>
      guard(() => remoteDataSource.startRegistration(email: email));

  @override
  Future<Result<String>> verifyRegistrationCode({
    required String accountRequestId,
    required String code,
  }) => guard(
    () => remoteDataSource.verifyRegistrationCode(
      accountRequestId: accountRequestId,
      verificationCode: code,
    ),
  );

  @override
  Future<Result<AuthUser>> finishRegistration({
    required String registrationToken,
    required String password,
    required String fullName,
  }) => guard(() async {
    await remoteDataSource.finishRegistration(
      registrationToken: registrationToken,
      password: password,
    );
    await remoteDataSource.setFullName(fullName);
    return _currentAuthUser();
  });

  @override
  Future<Result<void>> logout() => guard(remoteDataSource.logout);

  @override
  Future<Result<AuthUser?>> getCurrentSession() => guard(() async {
    final profile = await remoteDataSource.getCurrentProfile();
    if (profile == null) return null;
    return _currentAuthUser(profile: profile);
  });

  /// Combines the current profile (name/email) with the current mess
  /// membership (role/phone/messId, if any) into one [AuthUser] — the two
  /// live in separate tables server-side (see `AuthRemoteDataSource`'s doc
  /// comment) but the app's domain treats them as one identity.
  Future<AuthUser> _currentAuthUser({UserProfileModel? profile}) async {
    final resolvedProfile = profile ?? await remoteDataSource.getCurrentProfile();
    if (resolvedProfile == null) {
      throw StateError('Expected an active session but found none.');
    }
    final membership = await remoteDataSource.getCurrentMembership();
    return AuthUser(
      id: resolvedProfile.authUserId.toString(),
      name: resolvedProfile.fullName ?? resolvedProfile.userName ?? '',
      email: resolvedProfile.email ?? '',
      role: switch (membership?.role) {
        MessMemberRole.manager => UserRole.manager,
        MessMemberRole.member || null => UserRole.member,
      },
      messId: membership?.messId.toString(),
      phone: membership?.phone,
    );
  }
}
