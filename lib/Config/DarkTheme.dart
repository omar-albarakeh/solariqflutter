import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Config/AppText.dart';

ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.backgroundDark,
    appBarTheme: const AppBarTheme(
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primary),
      ),
      labelStyle: AppTextStyles.subtitleText.copyWith(
        color: AppColor.textWhite,
      ),
    ),
  );
}