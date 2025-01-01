import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Config/AppText.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.backgroundLight,
      appBarTheme: const AppBarTheme(
        color: AppColor.primary,
        titleTextStyle: AppTextStyles.appBarTitle,
        iconTheme: IconThemeData(color: AppColor.textWhite),
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.appBarTitle,
        titleLarge: AppTextStyles.title,
        labelLarge: AppTextStyles.subtitleText,
        bodyLarge: AppTextStyles.bodyText,
        titleMedium: AppTextStyles.subtitleText,
        bodySmall: AppTextStyles.bodyText,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttonPrimary,
          textStyle: AppTextStyles.bodyText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
        labelStyle: AppTextStyles.subtitleText.copyWith(
          color: AppColor.textGray,
        ),
      ),
    );
  }
}
