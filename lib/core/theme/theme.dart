import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData get appTheme => _themeData;

ThemeData _themeData = ThemeData(
  useMaterial3: true,
  fontFamily: "Montserrat",
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColor.normalTextColor),
    foregroundColor: AppColor.normalTextColor,
  ),

  // scaffoldBG, applicable for aLL PAGES
  scaffoldBackgroundColor: AppColor.backgroundColor,
  // `fromSwatch` previously left every role but `primary` on Material's
  // default blue swatch — stock components (progress indicators, text
  // field error states, selection handles) quietly ignored the app's own
  // palette. `fromSeed` derives every role from it instead, with the
  // brand-critical ones pinned exactly rather than left to the algorithm.
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primaryColor,
    primary: AppColor.primaryColor,
    secondary: AppColor.secondaryColor,
    error: AppColor.errorColor,
    surface: AppColor.cardColor,
  ),
);
