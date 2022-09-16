import 'package:flutter/material.dart';

class AppTheme {
  final BorderRadius borderRadius = BorderRadius.circular(8);
  final Color cardBgColorBlack = Colors.black;
  final Color cardTextColorWhite = Colors.white;
  final double cardTextFontSize = 15.0;
  final TextStyle cardTextFamily =
      const TextStyle(fontSize: 32.0, color: Colors.white);
  //
  final Color colorWhite = Colors.white;
  final Color colorBlack = Colors.black;
  final Color colorPrimary = Color.fromARGB(255, 255, 255, 255);
  final Color colorPrimaryDark = Color.fromARGB(255, 0, 0, 0);
  final double fontSize15 = 15.0;
  final double fontSize20 = 20.0;
  final double fontSize25 = 25.0;
  final double fontSize30 = 30.0;
  final double iconsSize15 = 15.0;

  final Color fontColor = Colors.white;
  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: colorPrimary,
      // primaryColorDark: colorPrimaryDark,
      backgroundColor: Colors.black, // App全局背景顏色改變
      // Card Theme
      cardTheme: const CardTheme(
        color: Colors.black,
        clipBehavior: Clip.antiAlias,
      ),
      // Text Theme
      textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 12.0, color: fontColor),
        bodyMedium: TextStyle(fontSize: 14.0, color: fontColor),
        bodyLarge: TextStyle(fontSize: 16.0, color: fontColor),
        labelSmall: TextStyle(fontSize: 11.0, color: fontColor),
        labelMedium: TextStyle(fontSize: 12.0, color: fontColor),
        labelLarge: TextStyle(fontSize: 14.0, color: fontColor),
        titleSmall: TextStyle(fontSize: 14.0, color: fontColor),
        titleMedium: TextStyle(fontSize: 16.0, color: fontColor),
        titleLarge: TextStyle(fontSize: 22.0, color: fontColor),
        headlineSmall: TextStyle(fontSize: 24.0, color: fontColor),
        headlineMedium: TextStyle(fontSize: 28.0, color: fontColor),
        headlineLarge: TextStyle(fontSize: 32.0, color: fontColor),
      ),
      iconTheme: const IconThemeData(
        // size: 12.0,
        color: Colors.white,
      ),
    );
  }
}
