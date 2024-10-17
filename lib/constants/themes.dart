import 'package:delivery/common/views/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: DimsColors.white,
    fontFamily: "PublicSans",
    colorScheme: ColorScheme.light(
      primary: DimsColors.dmisBlue,
      secondary: DimsColors.deepBlue,
      error: DimsColors.error,
      // surface: DimsColors.greyBlue,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: DimsColors.deepBlue,
    fontFamily: "PublicSans",
    colorScheme: ColorScheme.light(
      primary: DimsColors.dmisBlue,
      secondary: DimsColors.greyBlue,
      error: DimsColors.error,
      // surface: DimsColors.deepBlue,
      brightness: Brightness.dark
    ),
  );
}