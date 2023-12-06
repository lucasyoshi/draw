import 'package:flutter/material.dart';

SnackBarThemeData buildSnackBarThemeData(
    SnackBarThemeData original, ColorScheme colorScheme) {
  return SnackBarThemeData(
    backgroundColor: colorScheme.surface,
    contentTextStyle: TextStyle(color: colorScheme.onSurface),
  );
}
