// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart' show Lottie;
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mass_management/features/splash/presentation/cubit/splash_state.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/constants/app_string.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Kick off the session check; the cubit owns the (cancellable) branding
    // delay timer and is torn down along with itself via BlocProvider, so
    // there is no leaked Timer tied to this widget's lifecycle anymore.
    context.read<SplashCubit>().checkSession();
    // AuthBloc is the router guard's source of truth — without this it
    // would sit at AuthInitial forever, since nothing else in the app ever
    // asks it to check the session.
    context.read<AuthBloc>().add(const CheckSessionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        // Guard against navigating on a disposed/unmounted context — this
        // is the fix for the original bug where the bare 5s Timer could
        // fire and call context.push after the widget was gone.
        if (!context.mounted) return;

        if (state is SplashAuthenticated) {
          // The router's redirect sends this to the mess-choice gate
          // instead when the account has no mess yet.
          context.push(AppRoute.dashboard);
        } else if (state is SplashUnauthenticated) {
          context.push(AppRoute.welcome);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.secondaryColor, AppColor.primaryColor],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Lottie.asset(AppImages.loader),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  AppString.appVersion,
                  style: AppStyle.smallText.copyWith(color: AppColor.cardColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
