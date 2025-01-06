import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Controllers/AuthController.dart';
import '../../Widgets/Auth/Logo.dart';
import '../../Widgets/Auth/SocialButoonRow.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import 'Auth_Handlers.dart';

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
  bool _isPasswordVisible = false;
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LogoWidget(width: 300,height: 100,),
                  const Text("Hello, Sign Up!", style: AppTextStyles.title),
                  CustomTextField(
                    label: 'Username',
                    icon: Icons.person,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColor.textWhite,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    label: 'Address',
                    icon: Icons.home,
                    controller: _addressController,
                  ),
                  const SizedBox(height: 7),
                  _buildTypeDropdown(),
                  const SizedBox(height: 20),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Sign Up",
                    onTap: () => AuthHandlers.handleSignUp(
                      context: context,
                      formKey: _formKey,
                      authController: AuthController(),
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      selectedType: selectedType,
                      phoneController: _phoneController,
                      addressController: _addressController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Or sign in using",
                    style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
                  ),
                  const SizedBox(height: 16),
                  SocialButtonsRow(handleGoogleSignIn: () => AuthHandlers.handleGoogleSignIn(context)),
                  const SizedBox(height: 20),
                  _buildLoginRedirect(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedType,
        hint: Text("Select Type", style: AppTextStyles.bodyText.copyWith(color: Colors.white)),
        dropdownColor: Colors.blueGrey,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: const SizedBox(),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedType = newValue;
          });
        },
        items: ['Engineer', 'User'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: AppTextStyles.bodyText.copyWith(color: Colors.white)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?", style: TextStyle(color: Colors.white)),
        InkWell(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: const Text(" Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
