import 'package:flutter/material.dart';

class ThemeClass{

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
      ),
    iconTheme: const IconThemeData(color: Colors.grey, size: 20),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w500),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
      ),
    iconTheme: const IconThemeData(color: Colors.white, size: 20),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w500),
    ),
  );
}