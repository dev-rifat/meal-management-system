import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/routes/app_page.dart' show AppPage, appRouter;
import 'package:mass_management/features/auth/presentation/blog/blog_state.dart' show LoginBloc;
import 'package:mass_management/utils/app_layout.dart' show ResponsiveLayout;

import 'features/maneger/pages/manager_screen.dart' show MessManagerPage;
import 'features/user_list/page/user_list.dart';




void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<LoginBloc>(
                  create: (_) => LoginBloc(),
                ),
              ],
              child: Builder(
                builder: (context) {
                  ResponsiveLayout.init(context); // init layout

                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'BLoC Auth Example',
                    routerConfig: appRouter,
                    theme: ThemeData(
                      fontFamily: "Montserrat",
                      useMaterial3: true,
                    ),
                  );
                  return MaterialApp(
                    home: UserListPage(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
