import 'package:draw_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme lightText(TextTheme original) {
  return TextTheme(
    displayLarge: GoogleFonts.manrope(textStyle: original.displayLarge),
    displayMedium: GoogleFonts.manrope(textStyle: original.displayMedium),
    displaySmall: GoogleFonts.manrope(textStyle: original.displaySmall),
    headlineMedium: GoogleFonts.manrope(textStyle: original.headlineMedium),
    headlineSmall: GoogleFonts.manrope(textStyle: original.headlineSmall),
    titleLarge: GoogleFonts.manrope(textStyle: original.titleLarge),
    titleMedium: GoogleFonts.manrope(textStyle: original.titleMedium),
    titleSmall: GoogleFonts.manrope(textStyle: original.titleSmall),
    bodyLarge: GoogleFonts.inter(textStyle: original.bodyLarge),
    bodyMedium: GoogleFonts.inter(textStyle: original.bodyMedium),
    bodySmall: GoogleFonts.inter(textStyle: original.bodySmall),
    labelLarge: GoogleFonts.inter(textStyle: original.labelLarge),
  ).apply(
    displayColor: lightColorScheme.onPrimary,
    bodyColor: lightColorScheme.onPrimary,
  );
}

TextTheme darkText(TextTheme original) {
  return TextTheme(
    displayLarge: GoogleFonts.manrope(textStyle: original.displayLarge),
    displayMedium: GoogleFonts.manrope(textStyle: original.displayMedium),
    displaySmall: GoogleFonts.manrope(textStyle: original.displaySmall),
    headlineMedium: GoogleFonts.manrope(textStyle: original.headlineMedium),
    headlineSmall: GoogleFonts.manrope(textStyle: original.headlineSmall),
    titleLarge: GoogleFonts.manrope(textStyle: original.titleLarge),
    titleMedium: GoogleFonts.manrope(textStyle: original.titleMedium),
    titleSmall: GoogleFonts.manrope(textStyle: original.titleSmall),
    bodyLarge: GoogleFonts.inter(textStyle: original.bodyLarge),
    bodyMedium: GoogleFonts.inter(textStyle: original.bodyMedium),
    bodySmall: GoogleFonts.inter(textStyle: original.bodySmall),
    labelLarge: GoogleFonts.inter(textStyle: original.labelLarge),
  ).apply(
    displayColor: darkColorScheme.onPrimary,
    bodyColor: darkColorScheme.onPrimary,
  );
}

// TextStyle buildTextStyle(Color color,
//     {double size = 16.0, FontWeight weight = FontWeight.w500}) {
//   return TextStyle(
//     color: color,
//     fontSize: size,
//     fontWeight: weight,
//     letterSpacing: defaultLetterSpacing,
//   );
// }

// const defaultLetterSpacing = 0.09;
