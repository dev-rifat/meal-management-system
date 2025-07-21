import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/auth/presentation/blog/blog_state.dart' show LoginBloc;
import 'package:mass_management/utils/app_layout.dart' show ResponsiveLayout;

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
                  // Safe place to initialize screen sizes
                  ResponsiveLayout.init(context);

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'BLoC Auth Example',
                    theme: ThemeData(
                      fontFamily: "Montserrat", // Optional
                      useMaterial3: true,
                    ),
                    home: Container(),
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
