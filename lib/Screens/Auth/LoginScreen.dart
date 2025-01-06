import 'package:flutter/material.dart';

import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Config/SharedPreferences.dart';
import '../../Controllers/AuthController.dart';
import '../../Services/GoogleServices.dart';
import '../../Widgets/Auth/Logo.dart';
import '../../Widgets/Auth/SocialButoonRow.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import 'SignUpScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isPasswordVisible = false;

  Future<void> _handleGoogleSignIn() async {
    try {
      final user = await GoogleAuthService().signInWithGoogle();
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${user.displayName}!")),
        );
        Navigator.pushReplacementNamed(context, '/home', arguments: user);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google sign-in failed: $e")),
      );
    }
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await _authController.loginController(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (response['status'] == 'success') {
        final accessToken = response['data']['accessToken'];
        final isSolarInfoComplete = response['data']['isSolarInfoComplete'] ?? false;

        await TokenStorage.saveToken(accessToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        Navigator.of(context).pushReplacementNamed(
          isSolarInfoComplete ? '/home' : '/solar-form',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoWidget(),
                Text("Hello, Sign In!", style: AppTextStyles.title),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: _emailController,
                  width: MediaQuery.of(context).size.width - 48,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
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
                  width: MediaQuery.of(context).size.width - 48,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement Forgot Password functionality
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.subtitleText
                          .copyWith(color: AppColor.textWhite),
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
                SocialButtonsRow(handleGoogleSignIn: _handleGoogleSignIn),
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
    );
  }
}
