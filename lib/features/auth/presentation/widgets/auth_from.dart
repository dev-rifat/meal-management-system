import 'package:flutter/material.dart';
import 'package:mass_management/core/utils/app_layout_helper.dart';
import 'package:mass_management/features/auth/presentation/widgets/sign_up_text_field_widget.dart'
    show userEmailField, userPasswordField, divider;
import '../../../../../utils/app_color.dart';
import '../../../../../utils/dimensions.dart';

class AuthForm extends StatelessWidget {
  final Function(String, String) onSubmit;
  const AuthForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userEmailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Card(
      elevation: 0,
      shape: AppLayoutHelper.roundedRectangleBorder.copyWith(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        side: const BorderSide(width: 1, color: AppColor.disableColor),
      ),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          userEmailField(userEmailController),

          divider(),
          userPasswordField(controller: passwordController),
        ],
      ),
    );
  }
}
