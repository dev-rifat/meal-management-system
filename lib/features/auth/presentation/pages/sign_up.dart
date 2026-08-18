import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/routes/app_route.dart' show AppRoute;
import 'package:mass_management/core/widgets/custom_app_button.dart'
    show CustomAppButton;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/auth/presentation/widgets/mess_choice_sheet.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart' show AppStyle;
import 'package:mass_management/core/theme/dimensions.dart' show Dimensions;

class SignupPage extends StatefulWidget {
  final MessChoiceResult messChoice;

  const SignupPage({super.key, required this.messChoice});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimpasswordController = TextEditingController();

  bool hidePassword = true;

  // Computed once and reused for every field's border/enabledBorder/focusedBorder
  // instead of allocating a new OutlineInputBorder on each of the ~36 accesses
  // (3 per field x ~12 fields) that happen on every build.
  late final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: AppColor.hintColor.withValues(alpha: 0.5)),
  );

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confrimpasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: emailController.text.trim(),
          username: usernameController.text.trim(),
          password: passwordController.text,
          role: widget.messChoice.role,
          messId: widget.messChoice.messId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // Only these two states trigger navigation/snackbar work below, so skip
      // the listener entirely for Loading/Initial/Unauthenticated emissions.
      listenWhen: (previous, current) =>
          current is AuthAuthenticated || current is AuthError,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // The router's redirect sends this to the mess-choice gate
          // instead when the account has no mess yet.
          context.go(AppRoute.dashboard);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,

        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          title: const Text("Signup"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(key: _formKey, child: _buildUserForm()),
              const SizedBox(height: 20),

              BlocBuilder<AuthBloc, AuthState>(
                // The builder only branches on AuthLoading vs. everything
                // else, so only rebuild when that boolean actually flips.
                buildWhen: (previous, current) =>
                    (previous is AuthLoading) != (current is AuthLoading),
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CustomAppButton(
                    text: "Sign Up",
                    widget: Text(
                      "Sign Up",
                      style: AppStyle.titleText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.cardColor,
                        fontSize: Dimensions.fontSizeMid,
                      ),
                    ),
                    buttonRadius: Dimensions.radiusDefault,
                    buttonColor: AppColor.primaryColor,
                    onPressed: _handleSubmit,
                  );
                },
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rawTitleText("Email", isRequired: true),
        _inputField(
          "Email",
          emailController,
          icon: Icons.email,
          validator: _validateEmail,
        ),
        _rawTitleText("User name", isRequired: true),

        _inputField(
          "Username",
          usernameController,
          icon: Icons.person,

          validator: (value) => _validateInput(value, "User name"),
        ),
        _rawTitleText("Phone numer", isRequired: true),

        _inputField(
          "Phone Number",
          phoneController,
          icon: Icons.phone,
          keyboard: TextInputType.phone,
          validator: (value) => _validateInput(value, "Phone numer"),
        ),

        _rawTitleText("Birthday", isRequired: false),

        _alertText("We celebrate birthdays! Add your DOB."),

        _datePickerField("Date of Birth", dobController),

        _rawTitleText("Password", isRequired: true),

        _inputField(
          "Password",
          passwordController,
          icon: Icons.lock,
          obscureText: hidePassword,
          suffix: _togglePassword(),
          validator: (value) => _validateInput(value, "Password"),
        ),
        _rawTitleText("Confirm Password", isRequired: true),

        _inputField(
          "Confirm Password",
          confrimpasswordController,
          icon: Icons.lock,
          obscureText: hidePassword,
          validator: (value) => _validateInput(value, "Confirm Password"),

          suffix: _togglePassword(),
        ),
      ],
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    bool obscureText = false,
    Widget? suffix,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator, // Optional custom validator
    int maxLines = 1,
    bool onlyNumbers = false, // Allow only numbers if true
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: onlyNumbers ? TextInputType.number : keyboard,

        maxLines: maxLines,

        validator: validator, // Only validate if passed
        decoration: InputDecoration(
          labelText: label,

          labelStyle: TextStyle(color: AppColor.hintColor),
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: suffix,
          focusColor: AppColor.primaryColor,
          border: _inputBorder,
          enabledBorder: _inputBorder,
          focusedBorder: _inputBorder,
        ),
      ),
    );
  }

  Widget _datePickerField(String label, TextEditingController controller) {
    return _inputField(
      label,
      controller,
      icon: Icons.calendar_today,
      suffix: IconButton(
        icon: const Icon(Icons.date_range),
        onPressed: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
      ),
    );
  }

  Widget _togglePassword() {
    return IconButton(
      icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(() {
          hidePassword = !hidePassword;
        });
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Please enter Email";
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  String? _validateInput(String? value, String type) {
    if (value == null || value.isEmpty) return "Please enter $type";

    return null;
  }

  _alertText(String s) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      color: AppColor.pendingBgColor.withValues(alpha: 0.2),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(Icons.help, color: AppColor.hintColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              s,
              maxLines: 3,
              style: AppStyle.normalText.copyWith(
                color: AppColor.pendingTextColor,
                fontSize: 13,
                fontStyle: FontStyle.italic, // italic style
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _rawTitleText(String title, {bool isRequired = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: isRequired
            ? [
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            : [],
      ),
    ),
  );
}
