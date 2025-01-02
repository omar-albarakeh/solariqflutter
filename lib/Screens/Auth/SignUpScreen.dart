import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import '../../Config/AppColor.dart';
import '../../Services/AuthServices.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import '../../Widgets/Common/SocialButtons.dart';
import '../../model/Auth/Users.dart';

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
  final AuthService _authService = AuthService();

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
                  _buildLogo(),
                  const SizedBox(height: 7),
                  const Text("Hello, Sign Up!", style: AppTextStyles.title),
                  const SizedBox(height: 8),
                  _buildTextField(
                    label: 'Username',
                    icon: Icons.person,
                    controller: _usernameController,
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
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
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Address',
                    icon: Icons.home,
                    controller: _addressController,
                  ),
                  const SizedBox(height: 12),
                  _buildTypeDropdown(),
                  const SizedBox(height: 20),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Sign Up",
                    onTap: _handleSignUp,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Or sign in using",
                    style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButtons(),
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

  Widget _buildLogo() {
    return Image.asset("assets/images/LOGO.png", width: 200, height: 150);
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      icon: icon,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
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
        items: _getDropdownItems(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    return <String>['Engineer', 'User']
        .map<DropdownMenuItem<String>>(
          (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: AppTextStyles.bodyText.copyWith(color: Colors.white),
        ),
      ),
    )
        .toList();
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
                builder: (context) => const LoginScreen(),
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

  Future<void> _handleSignUp() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _addressController.text.isEmpty ||
        selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select a type.')),
      );
      return;
    }

    // Create a Users object
    final newUser = Users(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      type: selectedType!,
      phoneNumber: _phoneController.text,
      address: _addressController.text,
    );

    try {
      final response = await _authService.signup(newUser);

      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful: ${response['message']}')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
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