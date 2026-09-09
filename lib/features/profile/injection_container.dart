import 'package:get_it/get_it.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:mass_management/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mass_management/features/profile/domain/repositories/profile_repository.dart';
import 'package:mass_management/features/profile/domain/usecases/get_current_profile.dart';
import 'package:mass_management/features/profile/presentation/cubit/profile_cubit.dart';

/// Registers every dependency the profile feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, after `initAuthInjection`
/// — [ProfileCubit] depends on auth's [LogoutUseCase].
void initProfileInjection(GetIt sl) {
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl<ProfileLocalDataSource>()),
  );

  sl.registerLazySingleton<GetCurrentProfile>(
    () => GetCurrentProfile(sl<ProfileRepository>()),
  );

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getCurrentProfile: sl<GetCurrentProfile>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );
}
