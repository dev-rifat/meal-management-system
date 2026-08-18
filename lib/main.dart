import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_page.dart' show buildAppRouter;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/core/theme/theme.dart';

void main() {
  setupServiceLocator();
  // Built once here (not inside MyApp.build) — the router owns navigation
  // state, so recreating it on every rebuild (e.g. ScreenUtilInit's builder
  // re-firing on layout changes) would reset the whole nav stack.
  final authBloc = sl<AuthBloc>();
  final appRouter = buildAppRouter(authBloc);
  runApp(MyApp(authBloc: authBloc, appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final GoRouter appRouter;

  const MyApp({super.key, required this.authBloc, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider<AuthBloc>.value(value: authBloc)],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Mess Manager',
            routerConfig: appRouter,
            theme: appTheme,
          ),
        );
      },
    );
  }
}
