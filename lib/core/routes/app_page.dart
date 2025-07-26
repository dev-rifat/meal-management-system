import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart' show AppRoute;
import 'package:mass_management/features/auth/presentation/pages/sign_in.dart';
import 'package:mass_management/features/deashboard/pages/dashboard_screen.dart';
import 'package:mass_management/features/main/main.dart' show MainNavScreen;
import 'package:mass_management/features/starting/view/splash_screen.dart' show SplashScreen;


class AppPage {
  static GoRouter config() {
    return GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          name: AppRoute.splash,
          builder: (_, __) => SplashScreen(),
        ),

        GoRoute(
          path: '/sign_in',
          name: AppRoute.login,
          builder: (_, __) => SignInScreen(),
        ),
          GoRoute(
          path: '/deashboard_screen',
          name: AppRoute.deashboard,
          builder: (_, __) => MainNavScreen(),
        ),

       
      ],
    );
  }
}
