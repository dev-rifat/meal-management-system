// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:mass_management/core/utils/app_layout_helper.dart' show AppLayoutHelper;
// import 'package:mass_management/core/utils/app_spacer.dart';
// import '../../../../utils/app_color.dart';
// import '../../../../utils/app_layout.dart';
// import '../../../../utils/app_style.dart';
// import '../../../../utils/dimensions.dart';
// import '../widgets/common_widget.dart';
// import '../widgets/sign_up_text_field_widget.dart';
//
//
// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     ResponsiveLayout.init(context);
//
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: Padding(
//         padding: AppLayoutHelper.horizontalMargin(),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   customSpacerHeight(height: 80),
//                   _buildTitleText(context),
//                   customSpacerHeight(height: 30),
//                   _buildInputCard(),
//                   customSpacerHeight(height: 30),
//                   _buildSignUpButton(),
//                   customSpacerHeight(height: 20),
//                   _buildGuestButton(),
//                   customSpacerHeight(height: 30),
//                   _buildNewUserCreate(context),
//                   customSpacerHeight(height: 90),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTitleText(BuildContext context) {
//     return titleTextLayout(
//       titleText: "Sign up\nto your account",
//       subText: "",
//       context: context,
//       subTitleText: "Welcome Back You've Been Missed!",
//     );
//   }
//
//   Widget _buildInputCard() {
//     return Card(
//       elevation: 0,
//       shape: AppLayoutHelper.roundedRectangleBorder.copyWith(
//         borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
//         side: const BorderSide(width: 1, color: AppColor.disableColor),
//       ),
//       shadowColor: Colors.grey.withOpacity(0.2),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           userNameField(controller.userNameController),
//           divider(),
//           userPhoneNumberField(controller.phoneController),
//           divider(),
//           userEmailField(controller.emailController),
//           divider(),
//           userPasswordField(),
//           divider(),
//           userConfirmPasswordField(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSignUpButton() {
//     return CustomAppButton(
//       text: "Sign Up",
//       widget: controller.isSignUpLoading.value
//           ? LoadingHelper.customLoading(
//         color: AppColor.cardColor,
//         sizeFactor: .8,
//       )
//           : Text(
//         "Sign Up",
//         style: AppStyle.mid_large_text.copyWith(fontWeight: FontWeight.bold),
//       ),
//       buttonRadius: Dimensions.radiusDefault,
//       buttonColor: AppColor.primaryColor,
//       onPressed: _handleSignUp,
//     );
//   }
//
//   void _handleSignUp() {
//     final c = controller;
//
//     // Optional: Autofill for testing (should be removed or wrapped in debug mode)
//     if (c.userNameController.text.isEmpty &&
//         c.emailController.text.isEmpty &&
//         c.passwordController.text.isEmpty &&
//         c.confirmPassController.text.isEmpty) {
//       // Only for testing or development
//       c.userNameController.text = "rifat.dev";
//       c.emailController.text = "rifat.dev@gmail.com";
//       c.passwordController.text = "Admin@123";
//       c.confirmPassController.text = "Admin@123";
//       c.phoneController.text = "+11-078535325";
//     }
//
//     // Validate form before proceeding
//     if (_formKey.currentState?.validate() ?? false) {
//       c.isSignUpLoading(true);
//
//       // Simulate a delay (e.g. API call)
//       Future.delayed(const Duration(seconds: 2), () {
//         c.isSignUpLoading(false);
//         _clearForm();
//         Get.offAllNamed(Routes.MAIN);
//       });
//     }
//   }
//
//
//   void _clearForm() {
//     controller.userNameController.clear();
//     controller.emailController.clear();
//     controller.passwordController.clear();
//     controller.confirmPassController.clear();
//     controller.phoneController.clear();
//   }
//
//   Widget _buildGuestButton() {
//     return guestButtonLayout();
//   }
//
//   Widget _buildNewUserCreate(BuildContext context) {
//     return createUserAccount(
//       context: context,
//       firstText: "Already have? ",
//       endText: "Sign In",
//       onAction: () {
//         Get.toNamed(Routes.SIGN_IN);
//         _clearForm();
//       },
//     );
//   }
// }
