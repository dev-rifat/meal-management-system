import 'package:get_it/get_it.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/splash/presentation/cubit/splash_cubit.dart';

/// Registers every dependency the splash feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, after `initAuthInjection(sl)`
/// — this feature only depends on auth's `CheckSessionUseCase` and
/// registers nothing of its own besides the cubit.
void initSplashInjection(GetIt sl) {
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(sl<CheckSessionUseCase>()),
  );
}
