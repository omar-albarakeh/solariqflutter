import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import '../../Config/AppColor.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import '../../Widgets/Common/SocialButtons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.linearGradient,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 10),
                  const Text("Hello, Sign Up!", style: AppTextStyles.title),
                  const SizedBox(height: 5),
                  _buildTextField(
                    label: 'Username',
                    icon: Icons.person,
                    controller: _usernameController,
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _passwordController,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    controller: _phoneController,
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    label: 'Address',
                    icon: Icons.home,
                    controller: _addressController,
                  ),
                  const SizedBox(height: 8),
                  _buildTypeDropdown(),
                  const SizedBox(height: 16),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Sign Up",
                    onTap: _handleSubmit,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Or sign in using",
                    style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButtons(),
                  const SizedBox(height: 30),
                  _buildLoginRedirect(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset("assets/images/LOGO.png", width: 234, height: 150);
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      label: label,
      icon: icon,
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedType,
        hint: Text(
          "Select Type",
          style: AppTextStyles.bodyText.copyWith(color: Colors.white),
        ),
        dropdownColor: Colors.blueGrey,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: const SizedBox(),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedType = newValue;
          });
        },
        items: <String>['Engineer', 'User']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppTextStyles.bodyText.copyWith(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          icon: Icons.email,
          color: Colors.redAccent,
          text: "Gmail",
          onTap: () {},
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.facebook,
          color: Colors.blueAccent,
          text: "Facebook",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Loginscreen(),
              ),
            );
          },
          child: const Text(
            " Login",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle signup logic
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    return null;
  }
}
