import 'package:flutter/material.dart';
import 'package:frontend/pallete.dart';


class AppTheme {
  static ThemeData theme = ThemeData(
    textTheme: const TextTheme(),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    fontFamily: 'Gilroy',
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.greenColor,
    ),
  );
}

TextStyle sub1 = const TextStyle(
  fontSize: 16,
  color: Color(0xFF929292),
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w500,
  letterSpacing: -0.59,

);

TextStyle h1 = const TextStyle(
  color: Colors.black,
  fontSize: 22,
  fontFamily: 'Gilroy',
  fontWeight:
  FontWeight.w600,
  letterSpacing: 1.12,
);