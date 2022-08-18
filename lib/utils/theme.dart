
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get data => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFBA7AFF),
        textTheme: TextTheme(
          bodySmall: TextStyle(
              color: purple800, fontSize: 12, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(
              color: purple800, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              color: purple900, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        primarySwatch: Colors.purple,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color?>(purple900),
              side: MaterialStateProperty.all<BorderSide?>(
                  BorderSide(color: purple900))),
        ),
        appBarTheme: const AppBarTheme(
            toolbarHeight: 70,
            backgroundColor: surface,
            foregroundColor: white,
            elevation: 10,
            shadowColor: Colors.black,
            centerTitle: true),
        //backgroundColor: const Color(0xFF49225D),
      );
}
