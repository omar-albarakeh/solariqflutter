import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Services/AuthServices.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import '../../Widgets/Common/SocialButtons.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColor.linearGradient,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  Text("Hello, Sign In!", style: AppTextStyles.title),
                  const SizedBox(height: 24),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _passwordController,
                    validator: _validatePassword,
                    isObscure: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.textWhite,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        onPressed: () {
                          // Forgot password functionality
                        },
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.subtitleText
                              .copyWith(color: AppColor.textWhite),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Login",
                    onTap: _handleLogin,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Or continue with",
                    style: AppTextStyles.bodyText
                        .copyWith(color: AppColor.textWhite),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButtons(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.asset("assets/images/LOGO.png", width: 234, height: 224),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      icon: icon,
      controller: controller,
      validator: validator,
      obscureText: isObscure,
      suffixIcon: suffixIcon,
      width: MediaQuery.of(context).size.width - 48,
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
          onTap: () {
            // Gmail login functionality
          },
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.facebook,
          color: Colors.blueAccent,
          text: "Facebook",
          onTap: () {
            // Facebook login functionality
          },
        ),
      ],
    );
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await _authService.login(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (response.containsKey('error')) {
          throw Exception(response['error']);
        }
        final accessToken = response['accessToken'];
        if (accessToken == null) {
          throw Exception('No access token returned.');
        }
        final userInfo = await _authService.getUserInfo(accessToken);
        print(userInfo);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );

        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: userInfo,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}