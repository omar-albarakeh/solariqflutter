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

  String? selectedType;

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
                  const Text("Hello, Sign Up!", style: AppTextStyles.title),
                  const SizedBox(height: 5),
                  _buildTextField(
                      label: 'Username',
                      icon: Icons.person,
                      controller: _usernameController
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                      label: 'Email',
                      icon: Icons.email,
                      controller: _emailController
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                      label: 'Password',
                      icon: Icons.lock,
                      controller: _passwordController
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                      label: 'Phone Number',
                      icon: Icons.phone,
                      controller: _phoneController
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                      label: 'Address',
                      icon: Icons.home,
                      controller: _addressController
                  ),
                  const SizedBox(height: 8),
                  _buildTypeDropdown(),
                  const SizedBox(height: 16),
                ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset("assets/images/LOGO.png", width: 234, height: 224);
  }

  Widget _buildTextField({required String label, required IconData icon, required TextEditingController controller}) {
    return CustomTextField(label: label, icon: icon, controller: controller);
  }
  Widget _buildTypeDropdown() {
    return Container(
      width: 350,
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
        items: <String>['Engineer', 'User']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppTextStyles.bodyText.copyWith(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
