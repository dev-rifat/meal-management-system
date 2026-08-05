import 'package:get_it/get_it.dart';
import 'package:mass_management/features/auth/injection_container.dart';
import 'package:mass_management/features/dashboard/injection_container.dart';
import 'package:mass_management/features/manager/injection_container.dart';
import 'package:mass_management/features/members/injection_container.dart';
import 'package:mass_management/features/profile/injection_container.dart';
import 'package:mass_management/features/splash/injection_container.dart';

final GetIt sl = GetIt.instance;

/// Wires every feature's dependencies into [sl]. Call once before `runApp`.
///
/// Order matters: `auth` registers `CheckSessionUseCase`/`LogoutUseCase`,
/// which `profile` and `splash` depend on — it must run first.
void setupServiceLocator() {
  initAuthInjection(sl);
  initDashboardInjection(sl);
  initManagerInjection(sl);
  initMembersInjection(sl);
  initProfileInjection(sl);
  initSplashInjection(sl);
}
