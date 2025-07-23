import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart' show CustomInputField, PasswordInputField;
import 'package:mass_management/utils/dimensions.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';


Widget userEmailField(controller, {Color? borderColor}) {
  return CustomInputField(
    hitText: AppString.text_enter_email_address,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      Icons.email_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor:borderColor ?? Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_email_field_is_required;
      } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
        return AppString.please_insert_a_valid_email_address;
      } else {
        return null;
      }
    },
  );
}
emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}


final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{2,}$'
);

userNameField(controller) {
  return CustomInputField(
    hitText: AppString.text_user_name,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      CupertinoIcons.person_alt_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_first_name_field_is_required;
      } else {
        return null;
      }
    },
  );
}

userPhoneNumberField(controller) {
  return CustomInputField(
    hitText: AppString.text_enter_phone_number,
    controller: controller,
    errorBorderColor: Colors.transparent,
    isHideLabelText: true,

    prefixIcon: Icon(
      CupertinoIcons.phone_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    textInputType: TextInputType.number,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),


  );
}

userPasswordField({String? hintText, required TextEditingController controller}) {
  return PasswordInputField(
    controller: controller,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: hintText ?? "Enter password",
    validator: (value) {
      if (value == null || value.isEmpty) {
        return AppString.the_password_field_is_required;
      } else if (!passwordRegex.hasMatch(value)) {
        return "Weak password. Use A-Z, a-z, 0-9 & symbol.";
      }
      else if(value.length<8){

        return "Password must be at least 8 characters";

      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

userConfirmPasswordField({String? hintText, required TextEditingController pasController}) {

  return PasswordInputField(
    controller: pasController,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normalText.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: hintText ?? "Enter confirm password",
    validator: (value) {
      final password = pasController.text.trim();
      final confirmPassword = value?.trim() ?? '';

      if (confirmPassword.isEmpty) {
        return AppString.the__confirm_password_field_is_required;
      } else if (password != confirmPassword) {
        return "Passwords do not match";
      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

Divider divider() {
  return const Divider(
    color: AppColor.disableColor,
  );
}
