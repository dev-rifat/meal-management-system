import 'package:flutter/cupertino.dart';
import 'package:mass_management/core/theme/app_color.dart';

class LoadingHelper {
  /// Custom loading widget with configurable size and color
  static Widget customLoading({Color? color, double sizeFactor = 1}) {
    return Center(
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 16 * sizeFactor,
        color: color ?? AppColor.primaryColor,
      ),
    );
  }

  /// Default loading widget with fixed radius and primary color
  static Widget defaultLoading() {
    return const Center(
      child: CupertinoActivityIndicator(
        color: AppColor.primaryColor,
        radius: 18,
      ),
    );
  }
}
