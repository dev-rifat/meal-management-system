import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/constants/app_string.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:mass_management/features/auth/presentation/cubit/registration_state.dart';
import 'package:mass_management/features/auth/presentation/widgets/mess_choice_sheet.dart';
import 'package:mass_management/features/auth/presentation/widgets/sign_up_text_field_widget.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_cubit.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_state.dart';

/// Opens the account-details sheet that follows a resolved [PendingMessChoice]
/// — collects name/email/phone/password, walks the email-verification
/// steps, creates the account, then creates/joins the mess captured
/// earlier. See the module doc in `registration_state.dart` for why this
/// spans three separate Blocs/Cubits.
Future<void> showUserInfoSheet(
  BuildContext context, {
  required PendingMessChoice pendingChoice,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: AppColor.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<RegistrationCubit>()),
        BlocProvider(create: (_) => sl<MessCubit>()),
      ],
      child: UserInfoSheet(pendingChoice: pendingChoice),
    ),
  );
}

enum _Step { accountInfo, verificationCode }

class UserInfoSheet extends StatefulWidget {
  final PendingMessChoice pendingChoice;

  const UserInfoSheet({super.key, required this.pendingChoice});

  @override
  State<UserInfoSheet> createState() => _UserInfoSheetState();
}

class _UserInfoSheetState extends State<UserInfoSheet> {
  _Step _step = _Step.accountInfo;
  bool _isBusy = false;
  String? _accountRequestId;

  final _accountFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submitAccountInfo() async {
    if (!(_accountFormKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<RegistrationCubit>();
    setState(() => _isBusy = true);
    unawaited(cubit.startRegistration(_emailController.text.trim()));
    final state = await cubit.stream.firstWhere(
      (s) => s is RegistrationCodeSent || s is RegistrationFailure,
    );
    if (!mounted) return;
    setState(() => _isBusy = false);
    if (state is RegistrationCodeSent) {
      setState(() {
        _accountRequestId = state.accountRequestId;
        _step = _Step.verificationCode;
      });
    } else if (state is RegistrationFailure) {
      _showError(state.message);
    }
  }

  Future<void> _submitCode() async {
    if (!(_codeFormKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<RegistrationCubit>();
    setState(() => _isBusy = true);
    unawaited(
      cubit.verifyCode(_accountRequestId!, _codeController.text.trim()),
    );
    final state = await cubit.stream.firstWhere(
      (s) => s is RegistrationVerified || s is RegistrationFailure,
    );
    if (!mounted) return;
    if (state is RegistrationVerified) {
      await _finishRegistrationAndCreateMess(state.registrationToken);
    } else if (state is RegistrationFailure) {
      setState(() => _isBusy = false);
      _showError(state.message);
    }
  }

  Future<void> _finishRegistrationAndCreateMess(String registrationToken) async {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(
      FinishRegistrationRequested(
        registrationToken: registrationToken,
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
      ),
    );
    final authState = await authBloc.stream.firstWhere(
      (s) => s is AuthAuthenticated || s is AuthError,
    );
    if (!mounted) return;
    if (authState is AuthError) {
      setState(() => _isBusy = false);
      _showError(authState.message);
      return;
    }

    final messCubit = context.read<MessCubit>();
    final phone = _phoneController.text.trim();
    if (widget.pendingChoice.isCreate) {
      unawaited(messCubit.createMess(widget.pendingChoice.value, phone));
    } else {
      unawaited(messCubit.joinMess(widget.pendingChoice.value, phone));
    }
    final messState = await messCubit.stream.firstWhere(
      (s) => s is MessReady || s is MessFailure,
    );
    if (!mounted) return;
    if (messState is MessFailure) {
      setState(() => _isBusy = false);
      _showError(messState.message);
      return;
    }

    final ready = messState as MessReady;
    if (widget.pendingChoice.isCreate) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Mess created'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Share this invite code with your members:'),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  ready.mess.inviteCode,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    }
    if (!mounted) return;
    // Refresh AuthBloc's user to pick up the new messId (create/join
    // itself doesn't touch auth state — see auth_bloc.dart's doc comment).
    context.read<AuthBloc>().add(const CheckSessionRequested());
    Navigator.of(context).pop();
    // Explicit `go` rather than leaning on the router's refresh-driven
    // redirect alone — see app_page.dart's routing doc for why.
    context.go(AppRoute.dashboard);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: switch (_step) {
            _Step.accountInfo => _buildAccountInfoStep(),
            _Step.verificationCode => _buildVerificationCodeStep(),
          },
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColor.hintColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildAccountInfoStep() {
    final isManager = widget.pendingChoice.isCreate;
    return Form(
      key: _accountFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDragHandle(),
          Text(
            isManager
                ? 'Almost there — set up your account'
                : 'Almost there — join as a member',
            style: AppStyle.titleText.copyWith(fontSize: Dimensions.fontSizeMid),
          ),
          const SizedBox(height: 20),
          userNameField(_nameController),
          const SizedBox(height: 12),
          userEmailField(_emailController),
          const SizedBox(height: 12),
          userPhoneNumberField(
            _phoneController,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? AppString.thePhoneNumberFieldIsRequired
                : null,
          ),
          const SizedBox(height: 12),
          userPasswordField(controller: _passwordController),
          const SizedBox(height: 12),
          userConfirmPasswordField(
            controller: _confirmPasswordController,
            passwordController: _passwordController,
          ),
          const SizedBox(height: 24),
          CustomAppButton(
            text: _isBusy ? 'Please wait...' : 'Continue',
            buttonColor: AppColor.primaryColor,
            buttonRadius: Dimensions.radiusDefault,
            onPressed: _isBusy ? null : _submitAccountInfo,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCodeStep() {
    return Form(
      key: _codeFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDragHandle(),
          Text(
            'Check your email',
            style: AppStyle.titleText.copyWith(fontSize: Dimensions.fontSizeMid),
          ),
          const SizedBox(height: 8),
          Text(
            'We sent a verification code to ${_emailController.text.trim()}.',
            style: AppStyle.normalText.copyWith(color: AppColor.hintColor),
          ),
          const SizedBox(height: 20),
          TextFormField(
            key: const ValueKey('verification-code'),
            controller: _codeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Verification code'),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Please enter the code'
                : null,
          ),
          const SizedBox(height: 24),
          CustomAppButton(
            text: _isBusy ? 'Please wait...' : 'Verify',
            buttonColor: AppColor.primaryColor,
            buttonRadius: Dimensions.radiusDefault,
            onPressed: _isBusy ? null : _submitCode,
          ),
        ],
      ),
    );
  }
}
