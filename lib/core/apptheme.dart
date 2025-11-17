import 'package:flutter/material.dart';

class AppTheme {
  static const Color fireOrange = Color(0xFFFF6A00);

  static ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: fireOrange,
      onPrimary: Colors.white,
      secondary: fireOrange,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xFFFFF8F0),
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: fireOrange,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: fireOrange,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: fireOrange,
      onPrimary: Colors.white,
      secondary: fireOrange,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xFF1A1A1A),
      onBackground: Colors.white,
      surface: Color(0xFF222222),
      onSurface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: fireOrange,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: fireOrange,
      foregroundColor: Colors.white,
    ),
  );
}
