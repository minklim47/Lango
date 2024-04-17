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
    )),
    expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(), backgroundColor: Colors.white),
  );
}