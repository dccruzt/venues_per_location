import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
    color: primaryColor,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  ),
);
