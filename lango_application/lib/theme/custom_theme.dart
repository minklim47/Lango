import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomTheme {
  static ThemeData get customTheme {
    return _customTheme;
  }

  static final ThemeData _customTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: AppColors.yellow, brightness: Brightness.light),
    useMaterial3: true,
    fontFamily: "Inter",
    scaffoldBackgroundColor: AppColors.cream,
    primaryColor: AppColors.yellow,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        AppColors.yellow,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        AppColors.white,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: AppColors.white,
        ),
      ),
      fixedSize: MaterialStateProperty.all<Size>(
        const Size.fromHeight(50), 
      ),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
        foregroundColor: MaterialStateProperty.all<Color>(
          AppColors.darkGrey,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.darkGrey,
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(50)
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 40, color: AppColors.darkGrey),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.darkGrey),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.darkGrey),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 20, color: AppColors.darkGrey),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 18, color: AppColors.darkGrey),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.darkGrey),
    ),

    expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(), backgroundColor: Colors.white),
  );
}
