import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/core/widgets/success_message.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/auth/presentation/widgets/auth_form.dart'
    show AuthForm, AuthFormState;
import 'package:mass_management/features/auth/presentation/widgets/mess_choice_sheet.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/constants/app_string.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import '../widgets/common_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authFormKey = GlobalKey<AuthFormState>();

  void _handleLoginPressed() {
    // Validate the surrounding Form, then ask AuthForm to hand back the
    // email/password it's actually holding instead of firing hardcoded values.
    if (_formKey.currentState?.validate() ?? false) {
      _authFormKey.currentState?.submit();
    }
  }

  void _handleAuthFormSubmit(String email, String password) {
    context.read<AuthBloc>().add(
      LoginRequested(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // Only these two states trigger navigation/snackbar work below, so skip
      // the listener entirely for Loading/Initial/Unauthenticated emissions.
      listenWhen: (previous, current) =>
          current is AuthAuthenticated || current is AuthError,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // The router's redirect sends this to the mess-choice gate
          // instead when the account has no mess yet.
          context.go(AppRoute.dashboard);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitleText(context),
                    const SizedBox(height: 30),

                    AuthForm(
                      key: _authFormKey,
                      onSubmit: _handleAuthFormSubmit,
                    ),

                    const SizedBox(height: 4),

                    _buildForgotPassword(context),

                    const SizedBox(height: 30),

                    _buildLoginButton(context),

                    const SizedBox(height: 30),

                    _buildNewUserCreate(context),

                    const SizedBox(height: 76),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return titleTextLayout(
      titleText: "Sign in\nto your account",
      subText: "",
      context: context,
      subTitleText: "Welcome Back You've Been Missed!",
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          // The dedicated forgot-password screen was removed as dead code;
          // there's nowhere to navigate yet, so just acknowledge the tap.
          onTap: () => showSuccessMessage(message: "Coming soon"),
          child: Text("Forgot password?", style: AppStyle.normalText),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      // The builder only branches on AuthLoading vs. everything else, so
      // only rebuild when that boolean actually flips.
      buildWhen: (previous, current) =>
          (previous is AuthLoading) != (current is AuthLoading),
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        }

        return CustomAppButton(
          text: "Login",
          widget: Text(
            "Login",
            style: AppStyle.titleText.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.cardColor,
              fontSize: Dimensions.fontSizeMid,
            ),
          ),
          buttonRadius: Dimensions.radiusDefault,
          buttonColor: AppColor.primaryColor,
          onPressed: _handleLoginPressed,
        );
      },
    );
  }

  Widget _buildNewUserCreate(BuildContext context) {
    return createUserAccount(
      context: context,
      firstText: "New user? ",
      endText: AppString.textSignUp,
      onAction: () => _openMessChoicePicker(context),
    );
  }

  /// "Create a mess" or "join one" is decided first, via a bottom sheet —
  /// only once that's resolved does the actual sign-up form open, carrying
  /// the choice along so the account is created already attached to it.
  Future<void> _openMessChoicePicker(BuildContext context) async {
    final choice = await pickMessChoice(context);
    if (choice == null || !context.mounted) return;
    context.push(AppRoute.signUp, extra: choice);
  }
}
