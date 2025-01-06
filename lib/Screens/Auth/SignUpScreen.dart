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
  bool _isPasswordVisible = false;

  String? selectedCity;
  String? selectedUserType;

  final List<String> cityList = [
    "Beirut",
    "Tripoli",
    "Sidon",
    "Tyre",
    "Zahle",
    "Jounieh",
    "Byblos",
    "Baalbek",
    "Aley",
    "Broummana",
    "Deir El Qamar",
    "Jezzine",
    "Batroun",
    "Bcharre",
    "Ehden"
  ];

  final List<String> userTypeList = [
    "User",
    "Engineer",
  ];

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
                  const LogoWidget(width: 300, height: 100),
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
                  _buildCityDropdown(),
                  const SizedBox(height: 7),
                  _buildUserTypeDropdown(),
                  const SizedBox(height: 20),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Sign Up",
                    onTap: () => _handleSignUp(context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Or sign in using",
                    style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
                  ),
                  const SizedBox(height: 16),
                  SocialButtonsRow(
                    handleGoogleSignIn: () => AuthHandlers.handleGoogleSignIn(context),
                  ),
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

  Widget _buildCityDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedCity,
        hint: Text(
          "Select City",
          style: AppTextStyles.bodyText.copyWith(color: Colors.white),
        ),
        dropdownColor: Colors.blueGrey,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: const SizedBox(),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedCity = newValue;
          });
        },
        items: cityList.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(
              city,
              style: AppTextStyles.bodyText.copyWith(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedUserType,
        hint: Text(
          "Select User Type",
          style: AppTextStyles.bodyText.copyWith(color: Colors.white),
        ),
        dropdownColor: Colors.blueGrey,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: const SizedBox(),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedUserType = newValue;
          });
        },
        items: userTypeList.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: AppTextStyles.bodyText.copyWith(color: Colors.white),
            ),
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
          child: const Text(" Login",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a city!")),
        );
        return;
      }

      if (selectedUserType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a user type!")),
        );
        return;
      }

      AuthHandlers.handleSignUp(
        context: context,
        formKey: _formKey,
        authController: AuthController(),
        usernameController: _usernameController,
        emailController: _emailController,
        passwordController: _passwordController,
        phoneController: _phoneController,
        addressController: TextEditingController(text: selectedCity),
        selectedType: selectedUserType,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields!")),
      );
    }
  }
}
