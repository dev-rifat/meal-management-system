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
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
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
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRoute.dashboard);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
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

                    const SizedBox(height: 24),

                    guestButtonLayout(context),

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
      onAction: () => context.push(AppRoute.signUp),
    );
  }
}
