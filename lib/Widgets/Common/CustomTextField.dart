import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/AppText.dart';


class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextField(
        controller: controller,
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
            borderSide: BorderSide(color: AppColor.textGray),
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
