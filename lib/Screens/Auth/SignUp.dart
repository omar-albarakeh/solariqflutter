import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';

import '../../Config/AppColor.dart';
import '../../Widgets/Common/CustomTextField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
                          const SizedBox(height: 10),
                          Text("Hello, Sign Up!", style: AppTextStyles.title),
                          const SizedBox(height: 5),
                          _buildTextField(label: 'Username',
                              icon: Icons.person,
                              controller: _usernameController),
                          const SizedBox(height: 8),
                          _buildTextField(label: 'Email',
                              icon: Icons.email,
                              controller: _emailController),
                          const SizedBox(height: 8),
                          _buildTextField(label: 'Password',
                              icon: Icons.lock,
                              controller: _passwordController),
                          const SizedBox(height: 8),
                          _buildTextField(label: 'Phone Number',
                              icon: Icons.phone,
                              controller: _phoneController),
                          const SizedBox(height: 8),
                          _buildTextField(label: 'Address',
                              icon: Icons.home,
                              controller: _addressController),
                          const SizedBox(height: 8),
                        ])))));
  }


  Widget _buildLogo() {
    return Image.asset("assets/images/LOGO.png", width: 234, height: 224);
  }

  Widget _buildTextField({required String label,
    required IconData icon,
    required TextEditingController controller}) {
    return CustomTextField(label: label, icon: icon, controller: controller);
  }
}