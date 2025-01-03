import 'package:flutter/material.dart';

class AppColor{
  static const LinearGradient linearGradient = LinearGradient(
    colors: [Colors.orange, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color primary = Colors.orange;
  static const Color secondary = Colors.lightGreen;

  static const Color buttonPrimary = Colors.orange;
  static const Color buttonSecondary = Colors.lightGreen;
  static const Color buttonBorder = Color(0xFF686666);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color divider = Color(0xFFE0E0E0);

  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);
  static const Color textGray = Color(0xFFB0B0B0);
}