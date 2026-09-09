import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart'
    show CustomInputField, PasswordInputField;
import 'package:mass_management/core/theme/dimensions.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/constants/app_string.dart';
import 'package:mass_management/core/theme/app_style.dart';

Widget userEmailField(TextEditingController controller, {Color? borderColor}) {
  return CustomInputField(
    hintText: AppString.textEnterEmailAddress,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      Icons.email_outlined,
      color: AppColor.hintColor.withValues(alpha: 0.6),
    ),
    borderColor: borderColor ?? Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.theEmailFieldIsRequired;
      } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
        return AppString.pleaseInsertAValidEmailAddress;
      } else {
        return null;
      }
    },
  );
}

String emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}

final RegExp passwordRegex = RegExp(
  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{2,}$',
);

Widget userNameField(TextEditingController controller) {
  return CustomInputField(
    hintText: AppString.textUserName,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      CupertinoIcons.person_alt_circle,
      color: AppColor.hintColor.withValues(alpha: 0.6),
    ),
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.theUserNameFieldIsRequired;
      } else {
        return null;
      }
    },
  );
}

Widget userPhoneNumberField(
  TextEditingController controller, {
  String? Function(String?)? validator,
}) {
  return CustomInputField(
    hintText: AppString.textEnterPhoneNumber,
    controller: controller,
    errorBorderColor: Colors.transparent,
    isHideLabelText: true,
    prefixIcon: Icon(
      CupertinoIcons.phone_circle,
      color: AppColor.hintColor.withValues(alpha: 0.6),
    ),
    borderColor: Colors.transparent,
    textInputType: TextInputType.number,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: validator,
  );
}

Widget userPasswordField({
  String? hintText,
  required TextEditingController controller,
}) {
  return PasswordInputField(
    controller: controller,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hintText: hintText ?? "Enter password",
    validator: (value) {
      if (value == null || value.isEmpty) {
        return AppString.thePasswordFieldIsRequired;
      } else if (!passwordRegex.hasMatch(value)) {
        return "Weak password. Use A-Z, a-z, 0-9 & symbol.";
      } else if (value.length < 8) {
        return "Password must be at least 8 characters";
      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withValues(alpha: 0.6),
    ),
  );
}

/// [controller] backs this field's own text; [passwordController] is only
/// read (never bound) to check the two match.
Widget userConfirmPasswordField({
  String? hintText,
  required TextEditingController controller,
  required TextEditingController passwordController,
}) {
  return PasswordInputField(
    controller: controller,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hintText: hintText ?? "Enter confirm password",
    validator: (value) {
      final password = passwordController.text.trim();
      final confirmPassword = value?.trim() ?? '';

      if (confirmPassword.isEmpty) {
        return AppString.theConfirmPasswordFieldIsRequired;
      } else if (password != confirmPassword) {
        return "Passwords do not match";
      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withValues(alpha: 0.6),
    ),
  );
}

Divider divider() {
  return const Divider(color: AppColor.disableColor);
}
