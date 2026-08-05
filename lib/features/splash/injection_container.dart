import 'package:get_it/get_it.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/splash/presentation/cubit/splash_cubit.dart';

/// Registers every dependency the splash feature needs into [sl].
///
/// This is NOT called anywhere yet — a central `service_locator.dart`
/// (owned by a different part of this refactor) will call
/// `initSplashInjection(sl)` once it exists, alongside similar init
/// functions for other features. It must run after `initAuthInjection(sl)`
/// (or any registration of `CheckSessionUseCase`), since this feature only
/// depends on auth's already-migrated domain layer and registers nothing
/// of its own besides the cubit.
void initSplashInjection(GetIt sl) {
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(sl<CheckSessionUseCase>()),
  );
}
