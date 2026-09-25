import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_cubit.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_state.dart';

/// A mess name or invite code, captured *before* an account exists — the
/// actual create/join call happens later, once the account is
/// authenticated (`MessEndpoint.create`/`join` require login), via
/// `MessCubit` from `user_info_sheet.dart`.
class PendingMessChoice {
  final bool isCreate;
  final String value;

  const PendingMessChoice({required this.isCreate, required this.value});
}

/// Opens a single-purpose, dismissible bottom sheet that just captures a
/// mess name or invite code — no API call yet. [isCreate] matches whichever
/// welcome-screen button was tapped. Resolves to `null` if the user backs
/// out without entering anything.
Future<PendingMessChoice?> pickMessChoice(
  BuildContext context, {
  required bool isCreate,
}) {
  return showModalBottomSheet<PendingMessChoice>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _PendingMessChoiceSheet(isCreate: isCreate),
  );
}

class _PendingMessChoiceSheet extends StatefulWidget {
  final bool isCreate;

  const _PendingMessChoiceSheet({required this.isCreate});

  @override
  State<_PendingMessChoiceSheet> createState() =>
      _PendingMessChoiceSheetState();
}

class _PendingMessChoiceSheetState extends State<_PendingMessChoiceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(
      context,
      PendingMessChoice(
        isCreate: widget.isCreate,
        value: _controller.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.isCreate ? 'Create a new mess' : 'Join with a pass code',
                style: AppStyle.titleText.copyWith(
                  fontSize: Dimensions.fontSizeMid,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: ValueKey(widget.isCreate ? 'mess-name' : 'invite-code'),
                controller: _controller,
                textCapitalization: widget.isCreate
                    ? TextCapitalization.words
                    : TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: widget.isCreate ? 'Mess name' : 'Invite code',
                  hintText: widget.isCreate
                      ? 'e.g. Sunshine Mess'
                      : 'Enter the code your manager shared',
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? (widget.isCreate
                          ? 'Please enter a mess name'
                          : 'Please enter the invite code')
                    : null,
              ),
              const SizedBox(height: 24),
              CustomAppButton(
                text: 'Continue',
                buttonColor: AppColor.primaryColor,
                buttonRadius: Dimensions.radiusDefault,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens the create/join choice as a non-dismissible bottom sheet for an
/// *already-authenticated* session that has no mess yet — e.g. an old
/// account that predates the current welcome-screen-first sign-up flow.
/// Unlike [pickMessChoice], this one calls `MessCubit` immediately (an
/// account already exists), then refreshes `AuthBloc`'s current user so the
/// router's redirect picks up the new `messId` — create/join itself
/// doesn't touch auth state.
Future<void> showMessChoiceSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: AppColor.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) => BlocProvider(
      create: (_) => sl<MessCubit>(),
      child: const _MessChoiceGateSheet(),
    ),
  );
}

class _MessChoiceGateSheet extends StatefulWidget {
  const _MessChoiceGateSheet();

  @override
  State<_MessChoiceGateSheet> createState() => _MessChoiceGateSheetState();
}

class _MessChoiceGateSheetState extends State<_MessChoiceGateSheet> {
  bool _isCreateMode = true;
  final _formKey = GlobalKey<FormState>();
  final _messNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _messNameController.dispose();
    _inviteCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<MessCubit>();
    final phone = _phoneController.text.trim();
    if (_isCreateMode) {
      cubit.createMess(_messNameController.text.trim(), phone);
    } else {
      cubit.joinMess(_inviteCodeController.text.trim(), phone);
    }
  }

  Future<void> _handleReady(MessReady state) async {
    if (_isCreateMode) {
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
                  state.mess.inviteCode,
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
    context.read<AuthBloc>().add(const CheckSessionRequested());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Not skippable — the account isn't usable until this resolves.
      canPop: false,
      child: BlocListener<MessCubit, MessState>(
        listenWhen: (previous, current) =>
            current is MessReady || current is MessFailure,
        listener: (context, state) {
          if (state is MessReady) {
            _handleReady(state);
          } else if (state is MessFailure) {
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
                    'How will you use Mess Manager?',
                    style: AppStyle.titleText.copyWith(
                      fontSize: Dimensions.fontSizeMid,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildToggle(),
                  const SizedBox(height: 24),
                  if (_isCreateMode) _buildCreateForm() else _buildJoinForm(),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const ValueKey('phone'),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Phone number'),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Please enter your phone number'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<MessCubit, MessState>(
                    buildWhen: (previous, current) =>
                        (previous is MessSubmitting) !=
                        (current is MessSubmitting),
                    builder: (context, state) {
                      final submitting = state is MessSubmitting;
                      return CustomAppButton(
                        text: submitting
                            ? 'Please wait...'
                            : (_isCreateMode ? 'Create Mess' : 'Join Mess'),
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
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _toggleOption(
              'Create New Mess',
              _isCreateMode,
              () => setState(() => _isCreateMode = true),
            ),
          ),
          Expanded(
            child: _toggleOption(
              'Join a Mess',
              !_isCreateMode,
              () => setState(() => _isCreateMode = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleOption(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCreateForm() {
    return TextFormField(
      key: const ValueKey('mess-name'),
      controller: _messNameController,
      decoration: const InputDecoration(
        labelText: 'Mess name',
        hintText: 'e.g. Sunshine Mess',
      ),
      validator: (value) => (value == null || value.trim().isEmpty)
          ? 'Please enter a mess name'
          : null,
    );
  }

  Widget _buildJoinForm() {
    return TextFormField(
      key: const ValueKey('invite-code'),
      controller: _inviteCodeController,
      textCapitalization: TextCapitalization.characters,
      decoration: const InputDecoration(
        labelText: 'Invite code',
        hintText: 'Enter the code your manager shared',
      ),
      validator: (value) => (value == null || value.trim().isEmpty)
          ? 'Please enter the invite code'
          : null,
    );
  }
}
