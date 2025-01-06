import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
import '../../Controllers/AuthController.dart';
import '../../Services/GoogleServices.dart';

class AuthHandlers {
  static Future<void> handleSignUp({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required AuthController authController,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String? selectedType,
    required TextEditingController phoneController,
    required TextEditingController addressController,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        final response = await authController.signupController(
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          type: selectedType!,
          phoneNumber: phoneController.text.trim(),
          address: addressController.text.trim(),
        );

        Navigator.of(context).pop();

        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );

          Navigator.pushReplacementNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Signup failed')),
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }

  static Future<void> handleLogin({
    required BuildContext context,
    required AuthController authController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await authController.loginController(
        email: emailController.text.trim(),
        password: passwordController.text,
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

  static Future<void> handleGoogleSignIn(BuildContext context) async {
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
}
