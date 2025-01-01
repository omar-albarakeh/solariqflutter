import 'package:flutter/material.dart';

class AppColor{
  static const LinearGradient linearGradient = LinearGradient(
    colors: [Colors.teal, Colors.indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color buttonPrimary = Colors.orange;
  static const Color buttonSecondary = Colors.lightGreen;
  static const Color buttonBorder = Color(0xFF686666);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color divider = Color(0xFFE0E0E0);
}