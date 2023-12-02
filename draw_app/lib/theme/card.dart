import 'package:flutter/material.dart';

CardTheme buildCardTheme(CardTheme original, ColorScheme colorScheme) {
  return CardTheme(
    color: colorScheme.primary,
    shadowColor: colorScheme.onSurface.withOpacity(0.5),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: colorScheme.secondary,
        width: 1,
      ),
    ),
    margin: const EdgeInsets.all(10),
  );
}
