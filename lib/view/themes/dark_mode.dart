import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    dividerTheme: DividerThemeData(color: Colors.grey.shade200),
    colorScheme: ColorScheme.dark(
        surface: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: const Color.fromARGB(255, 57, 57, 57),
        tertiary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300));