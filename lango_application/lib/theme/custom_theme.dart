import 'package:flutter/material.dart';

import 'color_theme.dart';

class CustomTheme {
  static ThemeData get customTheme {
    return _customTheme;
  }

  static final ThemeData _customTheme = ThemeData(
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
