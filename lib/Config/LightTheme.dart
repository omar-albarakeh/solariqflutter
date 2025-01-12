import 'package:flutter/material.dart';
import 'AppColor.dart';
import 'AppText.dart';

class LightTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.backgroundLight,
      colorScheme: ColorScheme.light(
        primary: AppColor.blue,
        secondary: AppColor.blue,
        onPrimary: AppColor.textWhite,
        onSecondary: AppColor.textWhite,
      ),
      appBarTheme: AppBarTheme(
        color: AppColor.primary,
        titleTextStyle: AppTextStyles.appBarTitle,
        iconTheme: IconThemeData(color: AppColor.textWhite),
      ),
      textTheme: TextTheme(
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
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
        labelStyle: AppTextStyles.subtitleText.copyWith(
          color: AppColor.textGray,
        ),
      ),
    );
  }
}
