import 'package:flutter/material.dart';
import 'app_layout.dart';
import 'dimensions.dart';
import 'app_color.dart';

class AppStyle {
  AppStyle._();

  static TextStyle titleText = TextStyle(
    fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
    fontWeight: FontWeight.bold,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle smallText = TextStyle(
    fontSize: AppLayout.getWidth(Dimensions.fontSizeSmall),
    fontWeight: FontWeight.w400,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle normalText = TextStyle(
    fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
    fontWeight: FontWeight.w500,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle largeTextWhite = TextStyle(
    fontSize: AppLayout.getWidth(Dimensions.fontSizeExtraDefault),
    fontWeight: FontWeight.w600,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static BoxDecoration containerStyle = BoxDecoration(
    color: AppColor.normalTextColor,
    borderRadius: BorderRadius.circular(Dimensions.radiusMid),
  );
}
