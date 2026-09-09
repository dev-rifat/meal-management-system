import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/constants/app_string.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/auth/presentation/widgets/sign_up_text_field_widget.dart';

/// Opens the account-details sheet that follows a resolved create/join
/// choice — collects just enough to register (name, email, phone,
/// password) and dispatches [SignUpRequested] directly. The sheet pops
/// itself and navigates to the dashboard once the account is
/// authenticated — same as the sign-in screen's own listener, an
/// explicit `go` rather than leaning on the router's refresh-driven
/// redirect alone, since that redirect re-evaluates against the last
/// `go`-set location (`/welcome`'s own push doesn't update it).
Future<void> showUserInfoSheet(
  BuildContext context, {
  required String messId,
  required UserRole role,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => UserInfoSheet(messId: messId, role: role),
  );
}

class UserInfoSheet extends StatefulWidget {
  final String messId;
  final UserRole role;

  const UserInfoSheet({super.key, required this.messId, required this.role});

  @override
  State<UserInfoSheet> createState() => _UserInfoSheetState();
}

class _UserInfoSheetState extends State<UserInfoSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(
      SignUpRequested(
        email: _emailController.text.trim(),
        username: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        role: widget.role,
        messId: widget.messId,
      ),
    );
  }

  String? _requirePhone(String? value) =>
      (value == null || value.trim().isEmpty)
      ? AppString.thePhoneNumberFieldIsRequired
      : null;

  @override
  Widget build(BuildContext context) {
    final isManager = widget.role == UserRole.manager;
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthAuthenticated || current is AuthError,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pop();
          context.go(AppRoute.dashboard);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColor.hintColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  isManager
                      ? 'Almost there — set up your account'
                      : 'Almost there — join as a member',
                  style: AppStyle.titleText.copyWith(
                    fontSize: Dimensions.fontSizeMid,
                  ),
                ),
                const SizedBox(height: 20),
                userNameField(_nameController),
                const SizedBox(height: 12),
                userEmailField(_emailController),
                const SizedBox(height: 12),
                userPhoneNumberField(_phoneController, validator: _requirePhone),
                const SizedBox(height: 12),
                userPasswordField(controller: _passwordController),
                const SizedBox(height: 12),
                userConfirmPasswordField(
                  controller: _confirmPasswordController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      (previous is AuthLoading) != (current is AuthLoading),
                  builder: (context, state) {
                    final submitting = state is AuthLoading;
                    return CustomAppButton(
                      text: submitting ? 'Please wait...' : 'Create account',
                      buttonColor: AppColor.primaryColor,
                      buttonRadius: Dimensions.radiusDefault,
                      onPressed: submitting ? null : _submit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
