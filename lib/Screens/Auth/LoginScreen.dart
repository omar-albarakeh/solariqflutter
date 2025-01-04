import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Config/SharedPreferences.dart';
import '../../Controllers/AuthController.dart';
import '../../Services/GoogleServices.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import '../../Widgets/Auth/SocialButtons.dart';
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
        print("Google Sign-In successful: ${user.displayName}");
        Navigator.pushReplacementNamed(context, '/home', arguments: user);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google sign-in failed: $e")),
      );
    }
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
                _buildLogo(),
                Text("Hello, Sign In!", style: AppTextStyles.title),
                const SizedBox(height: 24),
                _buildTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: _passwordController,
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
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      icon: icon,
      controller: controller,
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
         onTap: _handleGoogleSignIn,
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

      print('Login response: $response');

      if (response == null || !response.containsKey('status') || !response.containsKey('data')) {
        throw Exception('Unexpected response structure');
      }

      if (response['status'] == 'success') {
        final accessToken = response['data']['accessToken'];
        print('Access Token: $accessToken');
        if (accessToken == null || accessToken.isEmpty) {
          throw Exception('Invalid token received');
        }

        try {
          await TokenStorage.saveToken(accessToken);
        } catch (e) {
          throw Exception('Failed to save token: ${e.toString()}');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        // Navigate to home screen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        throw Exception(response['message'] ?? 'Login failed');
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
}
