import 'package:flutter/cupertino.dart';
import '../../../utils/app_layout.dart';
import '../../../utils/dimensions.dart';

class AppLayoutHelper {
  /// Returns horizontal margin with default spacing
  static EdgeInsets horizontalMargin({double horizontal = 20}) {
    return EdgeInsets.only(
      left: AppLayout.getWidth(horizontal),
      right: AppLayout.getWidth(horizontal),
    );
  }

  /// Returns symmetric margin for horizontal and vertical spacing
  static EdgeInsets symmetricMargin({
    double horizontal = 20,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: AppLayout.getWidth(horizontal),
      vertical: AppLayout.getHeight(vertical),
    );
  }
  static RoundedRectangleBorder get roundedRectangleBorder {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusMid - 2),
    );
  }


}
