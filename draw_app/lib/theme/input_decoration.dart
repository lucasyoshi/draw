import 'package:draw_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

InputDecorationTheme lightInputDecoration(
    InputDecorationTheme original, TextTheme textTheme) {
  return original.copyWith(
    fillColor: lightColorScheme.primary,
    focusColor: lightColorScheme.onPrimary,
    contentPadding: const EdgeInsets.all(16),
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    border: _buildBorderStyle(lightColorScheme.onPrimary),
    enabledBorder: _buildBorderStyle(lightColorScheme.secondary),
    errorBorder: _buildBorderStyle(lightColorScheme.error),
    focusedErrorBorder: _buildBorderStyle(lightColorScheme.error),
    focusedBorder: _buildBorderStyle(lightColorScheme.onSecondary),
    disabledBorder: _buildBorderStyle(Colors.black26),
    suffixStyle: textTheme.bodySmall,
    iconColor: lightColorScheme.onPrimary,
    hintStyle: TextStyle(
      color: lightColorScheme.secondary, // Use color from color scheme
    ),
    prefixIconColor: lightColorScheme.onSecondary,
    labelStyle: TextStyle(
        color: lightColorScheme.onPrimary, // Use color from color scheme
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.4),
  );
}

InputDecorationTheme darkInputDecoration(
    InputDecorationTheme original, TextTheme textTheme) {
  return original.copyWith(
    fillColor: darkColorScheme.primary,
    filled: true,
    focusColor: darkColorScheme.onPrimary,
    contentPadding: const EdgeInsets.all(16),
    border: _buildBorderStyle(darkColorScheme.onPrimary),
    enabledBorder: _buildBorderStyle(darkColorScheme.secondary),
    errorBorder: _buildBorderStyle(darkColorScheme.error),
    focusedErrorBorder: _buildBorderStyle(darkColorScheme.error),
    focusedBorder: _buildBorderStyle(darkColorScheme.onSecondary),
    disabledBorder: _buildBorderStyle(Colors.black26),
    suffixStyle: textTheme.bodySmall,
    iconColor: darkColorScheme.onPrimary,
    hintStyle: TextStyle(
      color: darkColorScheme.secondary, // Use color from color scheme
    ),
    prefixIconColor: darkColorScheme.onSecondary,
    labelStyle: TextStyle(
        color: darkColorScheme.onPrimary, // Use color from color scheme
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.4),
  );
}

OutlineInputBorder _buildBorderStyle(Color color,
    {double width = 1.5, Radius borderRadius = const Radius.circular(10)}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(borderRadius),
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
  );
}
