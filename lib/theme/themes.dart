import 'package:flutter/material.dart';

class AppThemes {
static final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFFFFFF), // Background color for surfaces
    primary: Color(0xFF0C102C), // Primary color (dark blue)
    secondary: Color(0xFF1E2C4A), // Secondary color
    onPrimary: Color(0xFFFFFFFF), // Text/icon color on primary
  ),
);

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFF46322),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
