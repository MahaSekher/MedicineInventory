import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Color(0xFFB2DFDB),
      secondary: Color(0xFFFFCDD2),
    ),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFB2DFDB),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Color(0xFF757575),
        fontSize: 20,
      ),
    ),
  );
}
