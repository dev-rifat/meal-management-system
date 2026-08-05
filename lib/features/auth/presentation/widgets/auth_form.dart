import 'package:flutter/material.dart';
import 'package:mass_management/features/auth/presentation/widgets/sign_up_text_field_widget.dart'
    show userEmailField, userPasswordField, divider;
import '../../../../utils/app_color.dart';
import '../../../../utils/dimensions.dart';

/// Owns and disposes its own controllers (fixing the previous StatelessWidget
/// version, which recreated them on every rebuild and never disposed them),
/// and hands the typed email/password values back to [onSubmit] so callers
/// no longer have to read them out of nowhere.
class AuthForm extends StatefulWidget {
  final void Function(String email, String password) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Reads the current field values and forwards them to [AuthForm.onSubmit].
  void submit() {
    widget.onSubmit(emailController.text.trim(), passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColor.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        side: const BorderSide(width: 1, color: AppColor.disableColor),
      ),
      shadowColor: Colors.grey.withValues(alpha: 0.2),
      child: Column(
        children: [
          userEmailField(emailController),
          divider(),
          userPasswordField(controller: passwordController),
        ],
      ),
    );
  }
}
