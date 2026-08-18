import 'package:flutter/material.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/features/auth/presentation/widgets/mess_choice_sheet.dart';

/// Landed on whenever the router's redirect decides an authenticated
/// account has no mess yet — its only job is to open the create/join
/// bottom sheet. The redirect itself (not this widget) is what moves on
/// to the dashboard once a mess is attached, so there is nothing else to
/// build here.
class MessChoiceGate extends StatefulWidget {
  const MessChoiceGate({super.key});

  @override
  State<MessChoiceGate> createState() => _MessChoiceGateState();
}

class _MessChoiceGateState extends State<MessChoiceGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) showMessChoiceSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: AppColor.backgroundColor);
  }
}
