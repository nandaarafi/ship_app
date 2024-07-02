import 'package:flutter/material.dart';
import 'package:ship_apps/core/theme/text_theme.dart';

import '../constants/colors.dart';

class STheme {
  STheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: SColors.primaryColor,
    canvasColor: SColors.canvasColor,
    scaffoldBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(backgroundColor: Colors.white),
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    textTheme: STextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple,
      // primary: Colors.blue
    ),
  );
}