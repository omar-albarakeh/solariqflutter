import 'package:flutter/material.dart';
import 'AppColor.dart';
import 'AppText.dart';

class DarkTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.backgroundDark,
      colorScheme: ColorScheme.dark(
        primary: AppColor.primary,
        secondary: AppColor.buttonSecondary,
        onPrimary: AppColor.textWhite,
        onSecondary: AppColor.textWhite,
      ),
      appBarTheme: AppBarTheme(
        color: AppColor.backgroundDark,
        titleTextStyle: AppTextStyles.appBarTitle,
        iconTheme: IconThemeData(color: AppColor.textWhite),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.appBarTitle,
        titleLarge: AppTextStyles.title,
        labelLarge: AppTextStyles.subtitleText,
        bodyLarge: AppTextStyles.bodyText.copyWith(color: AppColor.textGray),
        titleMedium: AppTextStyles.subtitleText.copyWith(color: AppColor.textWhite),
        bodySmall: AppTextStyles.bodyText,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttonSecondary,
          textStyle: AppTextStyles.bodyText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Default grey border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
        labelStyle: AppTextStyles.subtitleText.copyWith(
          color: AppColor.textWhite,
        ),
      ),
    );
  }
}
