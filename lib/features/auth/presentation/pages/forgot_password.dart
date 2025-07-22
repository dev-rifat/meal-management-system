// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../routes/app_pages.dart';
// import '../../../../utils/app_color.dart';
// import '../../../../utils/app_style.dart';
// import '../../../global/utils/app_layout_helper.dart';
// import '../../../global/view/widgets/custom_app_button.dart';
// import '../../../global/view/widgets/custom_onloading.dart';
// import '../controllers/auth_controller.dart';
// import '../widgets/sign_up_text_field_widget.dart';
//
// class ForgotPasswordScreen extends GetView<AuthController> {
//   const ForgotPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Forgot Password',
//           style: AppStyle.large_text.copyWith(color: AppColor.normalTextColor),
//         ),
//       ),
//       body: Padding(
//         padding: AppLayoutHelper.horizontalMargin(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 50),
//             Text(
//               'Forgot Password?',
//               style: AppStyle.large_text.copyWith(
//                 fontWeight: FontWeight.w900,
//                 color: AppColor.normalTextColor,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Enter your email address and we will send you a link to reset your password.',
//               style: AppStyle.normal_text_black.copyWith(
//                 color: AppColor.hintColor,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             userEmailField(
//               controller.emailController,
//               borderColor: AppColor.disableColor,
//             ),
//             const SizedBox(height: 20),
//             Obx(
//               () => controller.isForgotPasswordLoading.isTrue
//                   ? LoadingHelper.customLoading(
//                       color: AppColor.primaryColor,
//                       sizeFactor: .8,
//                     )
//                   : _buildButton(),
//             ),
//             _backButton(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _backButton(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       child: const Text(
//         'Back to Login',
//         style: TextStyle(
//           color: Colors.blueAccent,
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   _buildButton() {
//     return CustomAppButton(
//       text: "Send Reset Link",
//       buttonColor: AppColor.primaryColor,
//       onPressed: () {
//         controller.emailController.text="rifat.dev@gmail.com";
//         controller.isForgotPasswordLoading(true);
//         Timer( Duration(seconds: 2), () {
//           controller.isForgotPasswordLoading(false);
//           controller.emailController.clear();
//           Get.offAllNamed(Routes.SIGN_IN);
//
//
//
//         });
//       },
//       buttonRadius: 8,
//     );
//   }
// }
