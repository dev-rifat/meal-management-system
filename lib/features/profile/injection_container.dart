import 'package:get_it/get_it.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:mass_management/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mass_management/features/profile/domain/repositories/profile_repository.dart';
import 'package:mass_management/features/profile/domain/usecases/get_current_profile.dart';
import 'package:mass_management/features/profile/presentation/cubit/profile_cubit.dart';

/// Registers every dependency the profile feature needs into [sl].
///
/// This is NOT called anywhere yet — a central `service_locator.dart`
/// (owned by a different part of this refactor) will call
/// `initProfileInjection(sl)` once it exists, alongside similar init
/// functions for other features (including `initAuthInjection`, which must
/// run first since [ProfileCubit] depends on auth's [LogoutUseCase]).
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
