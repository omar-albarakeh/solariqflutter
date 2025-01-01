import 'package:flutter/material.dart';

import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';
import '../../Widgets/Common/Buttons.dart';
import '../../Widgets/Common/CustomTextField.dart';
import '../../Widgets/Common/SocialButtons.dart';
import 'SignUp.dart';

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
                  _buildTextField(
                      label: 'Email',
                      icon: Icons.email,
                      controller: _emailController),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Password',
                      icon: Icons.lock,
                      controller: _passwordController),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.subtitleText
                              .copyWith(color: AppColor.textWhite),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Buttons(
                    hasBorder: false,
                    backgroundColor: AppColor.buttonPrimary,
                    buttonText: "Login",
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Or continue with ",
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

Widget _buildTextField(
    {required String label,
    required IconData icon,
    required TextEditingController controller}) {
  return CustomTextField(label: label, icon: icon, controller: controller);
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
