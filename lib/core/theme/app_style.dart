import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dimensions.dart';
import 'app_color.dart';

class AppStyle {
  AppStyle._();

  static TextStyle titleText = TextStyle(
    fontSize: Dimensions.fontSizeDefault.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle smallText = TextStyle(
    fontSize: Dimensions.fontSizeSmall.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle normalText = TextStyle(
    fontSize: Dimensions.fontSizeDefault.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static TextStyle largeTextWhite = TextStyle(
    fontSize: Dimensions.fontSizeExtraDefault.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.normalTextColor,
    fontFamily: 'Montserrat',
  );

  static BoxDecoration containerStyle = BoxDecoration(
    color: AppColor.normalTextColor,
    borderRadius: BorderRadius.circular(Dimensions.radiusMid),
  );
}
