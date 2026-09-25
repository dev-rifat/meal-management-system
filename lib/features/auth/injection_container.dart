import 'package:get_it/get_it.dart';
import 'package:mass_management/core/network/serverpod_client.dart';
import 'package:mass_management/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mass_management/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/finish_registration_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/start_registration_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/verify_registration_code_usecase.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Registers every dependency the auth feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, alongside the equivalent
/// init function for every other feature. Depends on the shared `Client`/
/// `PersistentAuthKeyManager` that `service_locator.dart` registers before
/// calling this.
void initAuthInjection(GetIt sl) {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl<Client>(),
      authKeyManager: sl<PersistentAuthKeyManager>(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<StartRegistrationUseCase>(
    () => StartRegistrationUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyRegistrationCodeUseCase>(
    () => VerifyRegistrationCodeUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<FinishRegistrationUseCase>(
    () => FinishRegistrationUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CheckSessionUseCase>(
    () => CheckSessionUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      finishRegistrationUseCase: sl<FinishRegistrationUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      checkSessionUseCase: sl<CheckSessionUseCase>(),
    ),
  );

  // Screen-local flow state for the two email-verification steps — see
  // registration_cubit.dart. Factory, not singleton: a fresh one per
  // sign-up attempt.
  sl.registerFactory<RegistrationCubit>(
    () => RegistrationCubit(
      startRegistrationUseCase: sl<StartRegistrationUseCase>(),
      verifyRegistrationCodeUseCase: sl<VerifyRegistrationCodeUseCase>(),
    ),
  );
}
