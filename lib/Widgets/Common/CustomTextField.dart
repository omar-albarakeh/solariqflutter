import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function added

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.validator, // Validator parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextFormField( // Changed from TextField to TextFormField
        controller: controller,
        validator: validator, // Attach the validator here
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColor.textWhite,
          ),
          labelText: label,
          labelStyle: AppTextStyles.subtitleText.copyWith(
            color: AppColor.textWhite,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColor.primary),
          ),
        ),
        style: AppTextStyles.bodyText.copyWith(color: AppColor.textWhite),
      ),
    );
  }
}
