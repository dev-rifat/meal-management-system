import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';


class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hitText;
  final Widget? suffixIcon;
  final double? corneRadius;
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
    this.corneRadius = 6,
    this.hintStyle,
    this.errorBorderColor,
    this.borderColor,
    this.isHideLabelText = false,
    this.cursorColor,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.inputDecoration,
    this.hitText,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    if (widget.prefixIcon != null && widget.suffixIcon != null) {
      return _buildTextFormField(_inputStyleForPrefixAndSuffix());
    } else if (widget.prefixIcon != null) {
      return _buildTextFormField(_inputStyleForPrefix());
    } else if (widget.suffixIcon != null) {
      return _buildTextFormField(_inputStyleForSuffix());
    } else {
      return _buildTextFormField(_inputStyle());
    }
  }

  TextFormField _buildTextFormField(InputDecoration decoration) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: widget.cursorColor ?? const Color(0xFF3B3B3B),
      validator: widget.validator,
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,
      decoration: widget.inputDecoration ?? decoration,
    );
  }

  InputDecoration _inputStyle() {
    if (widget.isHideLabelText == true) {
      return InputDecoration(
        labelStyle: widget.hintStyle ?? const TextStyle(),
        hintText: widget.hitText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
          borderSide: BorderSide(
              width: 1, color: widget.borderColor ?? Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
        ),
        hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: widget.errorBorderColor ?? Colors.transparent),
        ),
      );
    }

    return InputDecoration(
      labelText: widget.hitText ?? "Enter input here",
      labelStyle: widget.hintStyle ?? const TextStyle(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
        borderSide: BorderSide(
            width: 1, color: widget.borderColor ?? Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
      ),
      hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: widget.errorBorderColor ?? Colors.transparent),
      ),
    );
  }

  InputDecoration _inputStyleForPrefix() {
    return _inputStyle().copyWith(
      prefixIcon: widget.prefixIcon,
    );
  }

  InputDecoration _inputStyleForSuffix() {
    return _inputStyle().copyWith(
      suffixIcon: widget.suffixIcon,
    );
  }

  InputDecoration _inputStyleForPrefixAndSuffix() {
    return _inputStyle().copyWith(
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
    );
  }
}


class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hitText;
  final Widget? suffixWidget;
  final IconData? suffixVisibleIcon;
  final IconData? suffixHideIcon;
  final double? corneRadius;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? cursorColor;
  final InputDecoration? inputDecoration;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged; // Added onChange callback

  const PasswordInputField(
      {super.key,
        required this.controller,
        this.corneRadius,
        this.cursorColor,
        this.hintStyle,
        this.prefixIcon,
        this.borderColor,
        this.suffixHideIcon,
        this.inputDecoration,
        this.suffixVisibleIcon,
        this.hitText,
        this.onChanged,
        this.suffixWidget,
        this.validator});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {

    /// Widget according to style
    return widget.prefixIcon == null
        ? TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        cursorColor: widget.cursorColor?? const Color(0xFF3B3B3B),
        onChanged: widget.onChanged,
        decoration: widget.inputDecoration ?? _inputStyleForSuffix())
        : TextFormField(
        validator: widget.validator,
        obscureText: obscureText,
        cursorColor: widget.cursorColor?? const Color(0xFF3B3B3B),
        controller: widget.controller,
        onChanged: widget.onChanged,


        decoration:
        widget.inputDecoration ?? _inputStyleForSuffixAndPrefix());
  }

  _inputStyleForSuffix() {
    return InputDecoration(
      // labelText: widget.hitText ?? "Enter input here",
        labelStyle: widget.hintStyle ?? const TextStyle(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
            borderSide:  BorderSide(width: 1, color:widget.borderColor?? Colors.transparent )),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:widget.borderColor?? Colors.grey),
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: widget.borderColor?? Colors.grey),
            borderRadius: BorderRadius.circular(widget.corneRadius ?? 12)),

        suffixIcon: widget.suffixWidget ?? (_showPasswordIconLayout()),
        hintText: widget.hitText,
        hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),
        errorStyle: const TextStyle(
          color: Colors.red, // Set the color of the error text
          fontStyle: FontStyle.italic, // Set the style of the error text
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent),)

    );
  }

  _inputStyleForSuffixAndPrefix() {
    return InputDecoration(
      //   labelText: widget.hitText ?? "Enter input here",
        labelStyle: widget.hintStyle ?? const TextStyle(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
            borderSide:  BorderSide(width: 1, color:widget.borderColor?? Colors.transparent )),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:widget.borderColor?? Colors.grey),
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: widget.borderColor?? Colors.grey),
            borderRadius: BorderRadius.circular(widget.corneRadius ?? 12)),
        hintText: widget.hitText,

        suffixIcon: widget.suffixWidget ?? (_showPasswordIconLayout()),
        prefixIcon: widget.prefixIcon,
        hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),



        errorStyle: const TextStyle(
          color: Colors.red, // Set the color of the error text
          fontStyle: FontStyle.italic, // Set the style of the error text
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent),)

    );
  }

  _showPasswordIconLayout() {
    return IconButton(
      icon: Icon(
        obscureText
            ? widget.suffixHideIcon ?? CupertinoIcons.eye_slash
            : widget.suffixVisibleIcon ?? CupertinoIcons.eye,
      ),
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    );
  }
}