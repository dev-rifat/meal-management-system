import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_page.dart' show appRouter;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/utils/theme.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
          ],
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
