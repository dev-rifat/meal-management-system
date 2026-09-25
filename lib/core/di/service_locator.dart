import 'package:get_it/get_it.dart';
import 'package:mass_management/core/network/serverpod_client.dart';
import 'package:mass_management/features/auth/injection_container.dart';
import 'package:mass_management/features/dashboard/injection_container.dart';
import 'package:mass_management/features/manager/injection_container.dart';
import 'package:mass_management/features/members/injection_container.dart';
import 'package:mass_management/features/mess/injection_container.dart';
import 'package:mass_management/features/profile/injection_container.dart';
import 'package:mass_management/features/splash/injection_container.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

final GetIt sl = GetIt.instance;

/// Wires every feature's dependencies into [sl]. Call once before `runApp`.
///
/// Order matters: `auth` registers `CheckSessionUseCase`/`LogoutUseCase`,
/// which `profile` and `splash` depend on — it must run first.
void setupServiceLocator() {
  // Shared Serverpod client — auth and mess both talk to the same server
  // through it (see AuthRemoteDataSource's doc comment for why auth also
  // reaches into the mess endpoint).
  sl.registerLazySingleton<PersistentAuthKeyManager>(PersistentAuthKeyManager.new);
  sl.registerLazySingleton<Client>(
    () => Client(
      serverpodUrl,
      authenticationKeyManager: sl<PersistentAuthKeyManager>(),
    ),
  );

  initAuthInjection(sl);
  initDashboardInjection(sl);
  initManagerInjection(sl);
  initMembersInjection(sl);
  initMessInjection(sl);
  initProfileInjection(sl);
  initSplashInjection(sl);
}
