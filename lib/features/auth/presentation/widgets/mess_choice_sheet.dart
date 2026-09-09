import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_cubit.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_state.dart';

/// A resolved "Create New Mess" / "Join a Mess" choice, handed back by
/// [pickMessChoice] so the caller can carry it into sign-up.
class MessChoiceResult {
  final String messId;
  final UserRole role;

  const MessChoiceResult({required this.messId, required this.role});
}

/// Opens the create/join choice as a dismissible bottom sheet *before* an
/// account exists — used from the welcome screen's "Create a Mess" /
/// "Join with a Pass Code" buttons. [initiallyCreate] preselects the mode
/// matching whichever button was tapped; [allowModeSwitch] hides the
/// create/join toggle so the sheet only shows the field for that one
/// action (the generic entry point still gets the switchable toggle via
/// [showMessChoiceSheet]). Resolves to `null` if the user backs out
/// without choosing.
Future<MessChoiceResult?> pickMessChoice(
  BuildContext context, {
  bool initiallyCreate = true,
  bool allowModeSwitch = true,
}) {
  return _openSheet<MessChoiceResult>(
    context,
    locked: false,
    initiallyCreate: initiallyCreate,
    allowModeSwitch: allowModeSwitch,
    onChosen: (sheetContext, mess, role) {
      Navigator.pop(
        sheetContext,
        MessChoiceResult(messId: mess.id, role: role),
      );
    },
  );
}

/// Opens the create/join choice as a non-dismissible bottom sheet for an
/// *already-authenticated* session that has no mess yet (e.g. an old demo
/// account that predates this feature) — attaches the result directly via
/// [AttachMessRequested] since there's no sign-up step left to carry it
/// through.
Future<void> showMessChoiceSheet(BuildContext context) {
  return _openSheet<void>(
    context,
    locked: true,
    onChosen: (sheetContext, mess, role) {
      sheetContext.read<AuthBloc>().add(
        AttachMessRequested(messId: mess.id, role: role),
      );
      Navigator.pop(sheetContext);
    },
  );
}

Future<T?> _openSheet<T>(
  BuildContext context, {
  required bool locked,
  bool initiallyCreate = true,
  bool allowModeSwitch = true,
  required MessChosen onChosen,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: !locked,
    enableDrag: !locked,
    backgroundColor: AppColor.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) => BlocProvider(
      create: (_) => sl<MessCubit>(),
      child: MessChoiceSheet(
        locked: locked,
        initiallyCreate: initiallyCreate,
        allowModeSwitch: allowModeSwitch,
        onChosen: onChosen,
      ),
    ),
  );
}

typedef MessChosen =
    void Function(BuildContext context, Mess mess, UserRole role);

class MessChoiceSheet extends StatefulWidget {
  final bool locked;
  final bool initiallyCreate;
  final bool allowModeSwitch;
  final MessChosen onChosen;

  const MessChoiceSheet({
    super.key,
    required this.locked,
    this.initiallyCreate = true,
    this.allowModeSwitch = true,
    required this.onChosen,
  });

  @override
  State<MessChoiceSheet> createState() => _MessChoiceSheetState();
}

class _MessChoiceSheetState extends State<MessChoiceSheet> {
  late bool _isCreateMode = widget.initiallyCreate;
  final _formKey = GlobalKey<FormState>();
  final _messNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();

  @override
  void dispose() {
    _messNameController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<MessCubit>();
    if (_isCreateMode) {
      cubit.createMess(_messNameController.text.trim());
    } else {
      cubit.joinMess(_inviteCodeController.text.trim());
    }
  }

  Future<void> _handleReady(MessReady state) async {
    final createdNow = _isCreateMode;
    if (createdNow) {
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
    widget.onChosen(
      context,
      state.mess,
      createdNow ? UserRole.manager : UserRole.member,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Locked (post-auth gate): not skippable — the account isn't usable
      // until this resolves. Unlocked (pre-signup picker): backing out is
      // fine, there's no account yet to strand.
      canPop: !widget.locked,
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
                    widget.allowModeSwitch
                        ? 'How will you use Mess Manager?'
                        : (_isCreateMode
                              ? 'Create a new mess'
                              : 'Join with a pass code'),
                    style: AppStyle.titleText.copyWith(
                      fontSize: Dimensions.fontSizeMid,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.allowModeSwitch) _buildToggle(),
                  if (widget.allowModeSwitch) const SizedBox(height: 24),
                  if (_isCreateMode) _buildCreateForm() else _buildJoinForm(),
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
