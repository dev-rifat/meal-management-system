
import 'package:flutter/material.dart';



class AppLayout {
  static double getWidth(double pixel) {
    return ResponsiveLayout.scaleWidth(pixel);
  }

  static double getHeight(double pixel) {
    return ResponsiveLayout.scaleHeight(pixel);
  }
}


class ResponsiveLayout {
  static late double screenWidth;
  static late double screenHeight;

  static const double baseWidth = 375.0;
  static const double baseHeight = 812.0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  static double scaleWidth(double value) {
    return (value / baseWidth) * screenWidth;
  }

  static double scaleHeight(double value) {
    return (value / baseHeight) * screenHeight;
  }

  static double scaleText(double value) {
    return scaleWidth(value);
  }
}
