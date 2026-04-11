import 'package:flutter/material.dart';

abstract class AppColors {
  static const backgroundColor = Color(0xFFC0E1D2);
  static const secondary = Color(0xFFD6755B);
  static const primary = Color(0xFFF6F4E8);
  static const tertiaryColor = Color(0xFFE5EEE4);
  static const textColor = Colors.black;
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor,
);
