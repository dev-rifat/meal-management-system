import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart' show AppRoute;
import 'package:mass_management/core/utils/app_spacer.dart' show customSpacerHeight;
import 'package:mass_management/core/widgets/custom_app_button.dart' show CustomAppButton;
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';



Widget guestButtonLayout(BuildContext context) {
  return CustomAppButton(
      text: "",
      widget: Text(
        "Guest",
        style: AppStyle.titleText.copyWith(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
      onPressed: ()=> context.push(AppRoute.deashboard),
      
      btnBorderColor: AppColor.primaryColor,
      buttonRadius: Dimensions.radiusDefault,
      buttonColor: AppColor.cardColor);
}

titleTextLayout({context, titleText, subTitleText, subText}) {
  return Column(
    children: [
      Text(titleText,
          textAlign: TextAlign.center,
          style: AppStyle.titleText.copyWith(
              color: AppColor.normalTextColor,
              fontSize: ResponsiveLayout.scaleText(
                  Dimensions.fontSizeDoubleLarge - 4))),
      customSpacerHeight(height: 6),
      _subTextLayout(context, subTitleText, subText)
    ],
  );
}

_subTextLayout(context, text, subtext) {
  return Column(
    children: [
      Text(
        text,
        style: AppStyle.titleText
            .copyWith(color: Theme.of(context).disabledColor.withOpacity(0.5)),
      ),
      Text(
        subtext,
        style: AppStyle.titleText.copyWith(
            color: Theme.of(context).disabledColor.withOpacity(0.5),
            fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeDefault)),
      ),
    ],
  );
}

createUserAccount({context, firstText, endText, onAction}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: firstText,
              style: AppStyle.titleText.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.radiusMid)),
          TextSpan(
            text: endText,
            style: AppStyle.titleText.copyWith(
                color: Colors.blue,
                fontSize: Dimensions.radiusMid - 2,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = onAction,
          ),
        ],
      ),
    ),
  );
}


