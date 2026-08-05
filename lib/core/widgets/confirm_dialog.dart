import 'package:flutter/material.dart';
import 'package:mass_management/utils/app_color.dart';

/// Shared yes/no confirmation dialog — replaces the ad-hoc `AlertDialog`s
/// that used to be duplicated per screen (delete/update/logout confirmations).
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = "Confirm",
  String cancelLabel = "Cancel",
  bool isDestructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmLabel,
            style: TextStyle(color: isDestructive ? AppColor.errorColor : AppColor.primaryColor),
          ),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
