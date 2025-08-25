import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/utils/app_spacer.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart'
    show CustomAppButton;
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_layout.dart' show ResponsiveLayout;
import 'package:mass_management/utils/app_style.dart' show AppStyle, normalText;
import 'package:mass_management/utils/dimensions.dart' show Dimensions;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isMessSignup = false;
  final _formKey = GlobalKey<FormState>();
  final _createMessFormKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimpasswordController = TextEditingController();
  final codeController = TextEditingController();

  final messNameController = TextEditingController();
  final messNumberController = TextEditingController();
  final addressController = TextEditingController();
  final emergencyNumberController = TextEditingController();
  final cookInfoController = TextEditingController();

  bool hidePassword = true;

  get _inputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: AppColor.hintColor.withValues(alpha: 0.5)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isMessSignup ? "Create Mess" : "Signup"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildToggleButtons(),
            const SizedBox(height: 20),
            Form(
              key: isMessSignup ? _createMessFormKey : _formKey,
              child: isMessSignup ? _buildMessForm() : _buildUserForm(),
            ),
            const SizedBox(height: 20),

            CustomAppButton(
              text: isMessSignup ? "Create Mess" : "Sign Up",
              widget: Text(
                isMessSignup ? "Create Mess" : "Sign Up",
                style: AppStyle.titleText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.cardColor,
                  fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeMid),
                ),
              ),
              buttonRadius: Dimensions.radiusDefault,
              buttonColor: AppColor.primaryColor,
              onPressed: () {
                if (isMessSignup) {
                  if (_createMessFormKey.currentState!.validate()) {
                    // Handle signup
                  }
                }else{
                  if (_formKey.currentState!.validate()) {
                    // Handle signup
                  }
                }

               
                
              },
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  /// Toggle Buttons Full Width
  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMessSignup = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !isMessSignup
                      ? AppColor.primaryColor
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Text(
                  "Create User",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !isMessSignup ? Colors.white : AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMessSignup = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isMessSignup
                      ? AppColor.primaryColor
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  "Create Mess",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isMessSignup ? Colors.white : AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
          "Confirm Password",
          passwordController,
          icon: Icons.lock,
          obscureText: hidePassword,
          suffix: _togglePassword(),
          validator: (value) => _validateInput(value, "Password"),
        ),
        _rawTitleText("Email", isRequired: true),

        _inputField(
          "Confirm Password",
          confrimpasswordController,
          icon: Icons.lock,
          obscureText: hidePassword,
          validator: (value) => _validateInput(value, "Confirm Password"),

          suffix: _togglePassword(),
        ),
        _rawTitleText("Singup Code", isRequired: true),

        _alertText(
          "Enter the secret code to join your mess. You can find this code in your email inbox.",
        ),

        _inputField(
          "Signup Code",
          codeController,
          icon: Icons.verified,

          validator: (value) => _validateInput(value, "Singup Code"),
        ),
      ],
    );
  }

  Widget _buildMessForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rawTitleText("Mess Name", isRequired: true),

        _inputField(
          "Mess Name",
          messNameController,
          icon: Icons.home,

          validator: (value) => _validateInput(value, "Mess name"),
        ),
        _inputField(
          "Mess Number",
          messNumberController,
          icon: Icons.confirmation_number,
          keyboard: TextInputType.number,
          validator: (value) => _validateInput(value, "Mess mumber"),
        ),
        _rawTitleText("Mess Address", isRequired: true),

        _inputField(
          "Address",
          addressController,
          icon: Icons.location_on,
          maxLines: 2,
          validator: (value) => _validateInput(value, "Mess address"),
        ),
        _rawTitleText("Emergency Number", isRequired: false),
        _alertText("Add the house owner's contact number for quick help in emergencies."),

        _inputField(
          "Emergency Number (optional)",
          emergencyNumberController,
          icon: Icons.phone,
          keyboard: TextInputType.phone,
        ),
        _rawTitleText("Cook Info", isRequired: false),

        _inputField(
          "Cook Info (optional)",
          cookInfoController,
          icon: Icons.restaurant,
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
          customSpacerWidth(width: 8),
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
