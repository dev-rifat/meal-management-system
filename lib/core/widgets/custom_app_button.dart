import 'package:flutter/material.dart';
import 'package:mass_management/core/theme/app_color.dart';

/// The app's one button widget — every screen uses this instead of
/// `ElevatedButton` for a consistent look. Pass [widget] to render custom
/// content in place of [text] (e.g. an already-styled `Text`).
class CustomAppButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color btnBorderColor;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final Widget? widget;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double borderWidth;
  final VoidCallback? onPressed;
  final TextStyle? btnTextStyle;

  const CustomAppButton({
    super.key,
    this.text = "",
    this.widget,
    this.btnBorderColor = Colors.transparent,
    this.borderWidth = 1.0,
    this.buttonHeight = 48,
    this.buttonWidth,
    this.prefixWidget,
    this.suffixWidget,
    this.btnTextStyle,
    this.buttonColor = AppColor.primaryColor,
    this.buttonTextColor = AppColor.cardColor,
    this.onPressed,
    this.buttonRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(buttonRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(buttonRadius),
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: _buttonDecoration(),
          child: Center(
            child: widget ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefixWidget ?? const SizedBox.shrink(),
                    _spacer(),
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: _textStyle(),
                      ),
                    ),
                    _spacer(),
                    suffixWidget ?? const SizedBox.shrink(),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buttonDecoration() {
    return BoxDecoration(
      border: Border.all(width: borderWidth, color: btnBorderColor),
      color: buttonColor,
      borderRadius: BorderRadius.circular(buttonRadius),
    );
  }

  TextStyle _textStyle() {
    return btnTextStyle ?? TextStyle(color: buttonTextColor, fontSize: 17);
  }

  Widget _spacer() => const SizedBox(width: 12);
}
