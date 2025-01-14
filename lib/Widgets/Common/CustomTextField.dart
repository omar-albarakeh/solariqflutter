import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final double? width;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.width,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColor.textWhite,
          ),
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: AppTextStyles.subtitleText.copyWith(
            color: AppColor.textWhite,
            fontSize: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColor.primary),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
        style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
      ),
    );
  }
}
