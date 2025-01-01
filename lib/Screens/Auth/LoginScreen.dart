import 'package:flutter/material.dart';

import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Widgets/Common/CustomTextField.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  Text("Hello, Sign In!", style: AppTextStyles.title),
                  const SizedBox(height: 24),
                  _buildTextField(label: 'Email', icon: Icons.email, controller: _emailController),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Password', icon: Icons.lock, controller: _passwordController),
                  const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.subtitleText.copyWith(color: AppColor.textWhite),
                    ),
                  ),
                ),
              ),
                ]),
          ),
        ),
      ),
    );
  }
}

Widget _buildLogo() {
  return Image.asset("assets/images/LOGO.png", width: 234, height: 224);
}
Widget _buildTextField({required String label, required IconData icon, required TextEditingController controller}) {
  return CustomTextField(label: label, icon: icon, controller: controller);
}