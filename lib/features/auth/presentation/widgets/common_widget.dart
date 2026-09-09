import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';
import 'package:mass_management/core/theme/dimensions.dart';

Widget titleTextLayout({
  required String titleText,
  required String subTitleText,
  required String subText,
}) {
  return Column(
    children: [
      Text(
        titleText,
        textAlign: TextAlign.center,
        style: AppStyle.titleText.copyWith(
          color: AppColor.normalTextColor,
          fontSize: Dimensions.fontSizeDoubleLarge - 4,
        ),
      ),
      const SizedBox(height: 6),
      _subTextLayout(subTitleText, subText),
    ],
  );
}

Widget _subTextLayout(String text, String subtext) {
  return Column(
    children: [
      Text(
        text,
        style: AppStyle.titleText.copyWith(color: AppColor.hintColor),
      ),
      Text(
        subtext,
        style: AppStyle.titleText.copyWith(
          color: AppColor.hintColor,
          fontSize: Dimensions.fontSizeDefault,
        ),
      ),
    ],
  );
}

Widget createUserAccount({
  required String firstText,
  required String endText,
  required VoidCallback onAction,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: firstText,
            style: AppStyle.titleText.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.radiusMid,
            ),
          ),
          TextSpan(
            text: endText,
            style: AppStyle.titleText.copyWith(
              color: AppColor.primaryColor,
              fontSize: Dimensions.radiusMid - 2,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onAction,
          ),
        ],
      ),
    ),
  );
}
