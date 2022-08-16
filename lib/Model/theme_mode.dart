import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.grey[600]);
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey[400],
    colorScheme: const ColorScheme.dark(),
  );
}
