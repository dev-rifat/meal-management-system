import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:mass_management/core/theme/app_color.dart';

InputDecoration _baseInputDecoration({
  String? hintText,
  String? labelText,
  TextStyle? hintStyle,
  double cornerRadius = 12,
  Color? borderColor,
  Color? errorBorderColor,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(cornerRadius),
    borderSide: BorderSide(color: borderColor ?? Colors.transparent),
  );
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    labelStyle: hintStyle ?? const TextStyle(),
    hintStyle: hintStyle ?? TextStyle(color: AppColor.hintColor),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: border,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide(color: borderColor ?? AppColor.hintColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide(color: borderColor ?? AppColor.hintColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide(color: errorBorderColor ?? Colors.transparent),
    ),
    errorStyle: TextStyle(
      color: AppColor.errorColor,
      fontStyle: FontStyle.italic,
    ),
  );
}

/// Shared text-field styling used across the app's forms. Set
/// [isHideLabelText] to show [hintText] as a placeholder instead of a
/// floating label.
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final double cornerRadius;
  final bool isHideLabelText;
  final Widget? prefixIcon;
  final Color? cursorColor;
  final TextInputType? textInputType;
  final Color? borderColor;
  final Color? errorBorderColor;
  final TextStyle? hintStyle;
  final InputDecoration? inputDecoration;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomInputField({
    super.key,
    required this.controller,
    this.cornerRadius = 6,
    this.hintStyle,
    this.errorBorderColor,
    this.borderColor,
    this.isHideLabelText = false,
    this.cursorColor,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.inputDecoration,
    this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: cursorColor ?? AppColor.normalTextColor,
      validator: validator,
      keyboardType: textInputType,
      onChanged: onChanged,
      decoration: inputDecoration ??
          _baseInputDecoration(
            hintText: isHideLabelText ? hintText : null,
            labelText: isHideLabelText ? null : (hintText ?? "Enter input here"),
            hintStyle: hintStyle,
            cornerRadius: cornerRadius,
            borderColor: borderColor,
            errorBorderColor: errorBorderColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
    );
  }
}

/// Same styling as [CustomInputField], but obscures its text and manages
/// its own show/hide toggle.
class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixWidget;
  final IconData? suffixVisibleIcon;
  final IconData? suffixHideIcon;
  final double cornerRadius;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? cursorColor;
  final InputDecoration? inputDecoration;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const PasswordInputField({
    super.key,
    required this.controller,
    this.cornerRadius = 12,
    this.cursorColor,
    this.hintStyle,
    this.prefixIcon,
    this.borderColor,
    this.suffixHideIcon,
    this.inputDecoration,
    this.suffixVisibleIcon,
    this.hintText,
    this.onChanged,
    this.suffixWidget,
    this.validator,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: obscureText,
      cursorColor: widget.cursorColor ?? AppColor.normalTextColor,
      onChanged: widget.onChanged,
      decoration: widget.inputDecoration ??
          _baseInputDecoration(
            hintText: widget.hintText,
            cornerRadius: widget.cornerRadius,
            borderColor: widget.borderColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixWidget ?? _passwordVisibilityToggle(),
            hintStyle: widget.hintStyle,
          ),
    );
  }

  Widget _passwordVisibilityToggle() {
    return IconButton(
      icon: Icon(
        obscureText
            ? widget.suffixHideIcon ?? CupertinoIcons.eye_slash
            : widget.suffixVisibleIcon ?? CupertinoIcons.eye,
      ),
      onPressed: () => setState(() => obscureText = !obscureText),
    );
  }
}
