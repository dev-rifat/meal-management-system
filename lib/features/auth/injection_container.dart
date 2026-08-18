import 'package:get_it/get_it.dart';
import 'package:mass_management/core/network/api_client.dart';
import 'package:mass_management/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mass_management/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mass_management/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/auth/domain/usecases/attach_mess_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';

/// Registers every dependency the auth feature needs into [sl].
///
/// This is NOT called anywhere yet — a central `service_locator.dart`
/// (owned by a different part of this refactor) will call
/// `initAuthInjection(sl)` once it exists, alongside similar init functions
/// for other features.
void initAuthInjection(GetIt sl) {
  // Shared across features — only register it here if nobody has yet.
  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton<ApiClient>(() => ApiClient());
  }

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CheckSessionUseCase>(
    () => CheckSessionUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<AttachMessUseCase>(
    () => AttachMessUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      checkSessionUseCase: sl<CheckSessionUseCase>(),
      attachMessUseCase: sl<AttachMessUseCase>(),
    ),
  );
}
