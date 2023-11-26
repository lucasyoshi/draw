import 'package:flutter/material.dart';

TextButtonThemeData buildTextButtonThemeData(
    TextButtonThemeData original, ColorScheme colorScheme) {
  return TextButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
        foregroundColor: MaterialStateProperty.all(colorScheme.primary),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        )),
  );
}

OutlinedButtonThemeData buildOutlinedButtonThemeData(
    OutlinedButtonThemeData original, ColorScheme colorScheme) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
        foregroundColor: MaterialStateProperty.all(colorScheme.primary),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        )),
  );
}

ElevatedButtonThemeData buildElevatedButtonThemeData(
    ElevatedButtonThemeData? original, ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
        foregroundColor: MaterialStateProperty.all(colorScheme.primary),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        )),
        
  );
}
