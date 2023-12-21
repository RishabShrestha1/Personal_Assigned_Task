import 'package:flutter/material.dart';

ThemeData mytheme = ThemeData().copyWith(
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onSurface: Colors.transparent,
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
    ),
  ),
  cardTheme: const CardTheme(
    color: Colors.transparent,
  ),
);
