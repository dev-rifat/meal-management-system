
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimensions{
  Dimensions._();
//App Size
  static double fontSizeExtraSmall=10.0;
  static double fontSizeSmall=12.0;
  static double fontSizeDefault=14.0;
  static double fontSizeExtraDefault=16.0;
  static double fontSizeMid=18.0;
  static double fontSizeLarge=20.0;
  static double fontSizeExtraLarge=24.0;
  static double fontSizeDoubleLarge=28.0;

//padding
  static double paddingExtraSmall=2.0;
  static double paddingSmall=4.0;
  static double paddingDefault=8.0;
  static double paddingDefaultMid = 10.0;
  static double paddingDefaultExtra=12.0;
  static double paddingMid=16.0;
  static double paddingLarge=20.0;
  static double paddingExtraLarge=24.0;

  // Radius
  static double radiusExtraSmall=3.0;
  static double radiusSmall=4.0;
  static double radiusDefault=8.0;
  static double radiusMid=16.0;
  static double radiusLarge=24.0;
  static double radiusExtraLarge=40.0;
}


class Dimension1 {
  static final size = _Size();
  static final radius = _Radius();
  static final padding = _Padding();
  static final divider = _Divider();
  static final gridViewDimensions = _GridView();
}

//! ################################################

//* ------------------- Radius -------------------
class _Radius {
  final double max = 100.0.r;
  final double fortyEight = 48.0.r;
  final double fortyTwo = 42.0.r;
  final double thirtyTwo = 32.0.r;
  final double twentyFour = 24.0.r;
  final double twenty = 20.0.r;
  final double twentySix = 26.0.r;
  final double sixteen = 16.0.r;
  final double twelve = 12.0.r;
  final double ten = 10.0.r;
  final double eight = 8.0.r;
  final double six = 6.0.r;
  final double four = 4.0.r;
  final double three = 3.0.r;
  final double one = 1.0.r;
} //? ------------------- Radius -------------------

//! ################################################

//* ------------------- Padding -------------------
class _Padding {
  final HorizontalPadding horizontal = HorizontalPadding();
  final VerticalPadding vertical = VerticalPadding();
}

class HorizontalPadding {
  final double max = 16.0.w;
  final double extraMax = 24.0.w;
  final double ultraMax = 32.0.h;
  final double large = 12.0.w;
  final double medium = 8.0.w;
  final double small = 4.0.w;
  final double verySmall = 2.0.w;
}

class VerticalPadding {
  final double max = 16.0.h;
  final double extraMax = 24.0.h;
  final double ultraMax = 32.0.h;
  final double fortyYwo = 42.0.h;
  final double large = 12.0.h;
  final double medium = 8.0.h;
  final double small = 4.0.h;
  final double verySmall = 2.0.h;
} //? ------------------- Padding -------------------

//! ################################################

//* ------------------- Size -------------------
class _Size {
  final HorizontalSize horizontal = HorizontalSize();
  final VerticalSize vertical = VerticalSize();
}

class HorizontalSize {
  final double max = 375.0.w;
  final double forty = 40.0.w;
  final double four = 4.0.w;
  final double eight = 8.0.w;
  final double sixteen = 16.0.w;
  final double ten = 10.0.w;
  final double twenty = 20.0.w;
  final double twentyFour = 24.0.w;
  final double thirtyTwo = 32.0.w;
  final double thirtySix = 36.0.w;
  final double fiftyTwo = 52.0.w;
  final double fortyEight = 48.0.w;
  final double sixtyFour = 64.0.w;
  final double seventyTwo = 72.0.w;
  final double oneTwentyEight = 128.0.w;
  final double sizeS = 96.w;
  final double promotionCardSizedBoxWidth = 204.w;
  final double oneHundredFortyFive = 145.w;
}

class VerticalSize {
  final double max = 812.0.h;
  final double twoHundred = 200.0.h;
  final double oneHundred = 100.0.h;
  final double oneEighty = 200.0.h;
  final double one = 1.0.h;
  final double three = 3.0.h;
  final double four = 4.0.h;
  final double sixtyFour = 64.0.h;
  final double eight = 8.0.h;
  final double ten = 10.0.h;
  final double twelve = 12.0.h;
  final double sixteen = 16.0.h;
  final double twenty = 20.0.h;
  final double thirtyTwo = 32.0.h;
  final double thirteen = 13.0.h;
  final double twentyFour = 24.0.h;
  final double thirtySix = 36.0.h;
  final double carousel = 112.0.h;
  final double button = 56.0.h;
  final double fiveHundred = 500.h;
  final double twoSixty = 260.h;
  final double oneTwenty = 120.h;
  final double oneForty = 140.h;
  final double fiftyTwo = 52.h;
  final double sixtyTwo = 62.h;
  final double fortyEight = 48.h;
  final double twentySeven = 27.h;
  final double min = 0.0.h;
  final double forty = 40.0.h;
  final double seventyTwo = 72.0.h;
  final double eighty = 80.h;
  final double totalTopLayoutDashboard = 351.h;
  final double sizeS = 41.h;
  final double productCardHeight = 128.h;
  final double oneTwentyEight = 128.0.h;
  final double promotionCardSizedBoxHeight = 80.h;
} //? ------------------- Size -------------------

//! ################################################

//* ------------------- Divider -------------------
class _Divider {
  final double normal = 0.25.h;
  final double large = 0.5.h;
  final double veryLarge = 1.0.h;
  final double max = 4.0.h;
} //? ------------------- Divider -------------------

//* ------------------- GridView -------------------
class _GridView {
  final double maxCross = 200;
  final double childAspectRatio = 0.7;
  final double mainAxisSpacing = 20;
  final double crossAxisSpacing = 16;
} //? ------------------- GridView -------------------
