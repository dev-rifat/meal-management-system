import 'package:flutter/material.dart';
import 'package:mass_management/features/auth/presentation/widgets/sign_up_text_field_widget.dart';
import '../../../../core/utils/app_layout_helper.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimensions.dart';



class TextFieldLayout extends GetView<AuthController> {
  const TextFieldLayout({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: AppLayoutHelper.roundedRectangleBorder.copyWith(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          side: const BorderSide(width: 1, color: AppColor.disableColor)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          userEmailField(controller.emailController),

          divider(),
          userPasswordField(controller:controller. passwordController),
        ],
      ),
    );
  }
}
