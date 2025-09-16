import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  //! ---> Light Elevated Button Theme
  static final ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: Colors.deepOrange),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  //! ---> Dark Elevated Button Theme
  static final ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: Colors.deepOrange),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
