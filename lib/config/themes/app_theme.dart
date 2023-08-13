import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData? appTheme() {
    return ThemeData(
      buttonTheme: buttonTheme(),
      iconButtonTheme: iconButtonTheme(),
    );
  }

  // Button theme
  static ButtonThemeData? buttonTheme() {
    return const ButtonThemeData(
      buttonColor: Colors.blue,
    );
  }

  // Icon Button Theme
  static IconButtonThemeData? iconButtonTheme() {
    return const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          AppColors.blueColor,
        ),
        backgroundColor: MaterialStatePropertyAll(
          AppColors.blueColor,
        ),
      ),
    );
  }
}
