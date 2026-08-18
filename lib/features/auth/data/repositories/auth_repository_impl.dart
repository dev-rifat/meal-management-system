import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/core/error/failure.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mass_management/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mass_management/features/auth/data/models/login_request_model.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

/// Login hits the (demo) remote API; sign-up, logout and session lookups
/// are all served from the in-memory local data source since there is no
/// real backend for those yet.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        LoginRequestModel(email: email, password: password),
      );
      final baseUser = response.toEntity();
      // dummyjson has no concept of our roles — look up whatever role this
      // email signed up with locally, defaulting to member if unseen.
      final user = AuthUser(
        id: baseUser.id,
        name: baseUser.name,
        email: baseUser.email,
        token: baseUser.token,
        role: localDataSource.roleForEmail(email),
        messId: localDataSource.messIdForEmail(email),
      );
      localDataSource.saveSession(user);
      return ResultSuccess(user);
    } on NetworkException catch (e) {
      return ResultError(NetworkFailure(e.message));
    } on UnauthenticatedException catch (e) {
      return ResultError(UnauthenticatedFailure(e.message));
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<AuthUser>> signUp({
    required String email,
    required String username,
    required String password,
    required UserRole role,
    required String messId,
  }) async {
    try {
      final user = localDataSource.registerUser(
        email: email,
        username: username,
        password: password,
        role: role,
        messId: messId,
      );
      return ResultSuccess(user);
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<void>> logout() async {
    localDataSource.clearSession();
    return const ResultSuccess(null);
  }

  @override
  Future<Result<AuthUser?>> getCurrentSession() async {
    return ResultSuccess(localDataSource.currentUser);
  }

  @override
  Future<Result<AuthUser>> attachMess({
    required String messId,
    required UserRole role,
  }) async {
    try {
      final user = localDataSource.attachMess(messId: messId, role: role);
      return ResultSuccess(user);
    } on UnauthenticatedException catch (e) {
      return ResultError(UnauthenticatedFailure(e.message));
    }
  }
}
