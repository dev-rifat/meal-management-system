import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/presentation/widgets/mess_choice_sheet.dart';
import 'package:mass_management/features/auth/presentation/widgets/user_info_sheet.dart';

/// First screen a session-less user sees: the two things they can actually
/// do — create a mess or join one with a pass code — are front and center,
/// instead of being buried behind a "New user? Sign up" text link on the
/// sign-in screen. Each button chains straight into the matching bottom
/// sheet (mess name / pass code) and then the account-details sheet.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _startMessFlow(BuildContext context, {required bool create}) async {
    final choice = await pickMessChoice(
      context,
      initiallyCreate: create,
      allowModeSwitch: false,
    );
    if (choice == null || !context.mounted) return;
    await showUserInfoSheet(context, messId: choice.messId, role: choice.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Mess Manager',
                textAlign: TextAlign.center,
                style: AppStyle.titleText.copyWith(
                  fontSize: Dimensions.fontSizeDoubleLarge,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create a new mess or join one your manager already set up.',
                textAlign: TextAlign.center,
                style: AppStyle.normalText.copyWith(color: AppColor.hintColor),
              ),
              const SizedBox(height: 48),
              CustomAppButton(
                text: 'Create a Mess',
                buttonColor: AppColor.primaryColor,
                buttonRadius: Dimensions.radiusDefault,
                onPressed: () => _startMessFlow(context, create: true),
              ),
              const SizedBox(height: 16),
              CustomAppButton(
                text: 'Join with a Pass Code',
                buttonColor: AppColor.backgroundColor,
                buttonTextColor: AppColor.primaryColor,
                btnBorderColor: AppColor.primaryColor,
                buttonRadius: Dimensions.radiusDefault,
                onPressed: () => _startMessFlow(context, create: false),
              ),
              const SizedBox(height: 32),
              Center(
                child: GestureDetector(
                  onTap: () => context.push(AppRoute.login),
                  child: RichText(
                    text: TextSpan(
                      style: AppStyle.normalText.copyWith(
                        color: AppColor.hintColor,
                      ),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
