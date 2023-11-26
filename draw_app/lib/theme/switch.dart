import 'package:flutter/material.dart';

SwitchThemeData switchTheme(SwitchThemeData original, ColorScheme colorScheme) {
  return original.copyWith(
    trackColor: trackColor(colorScheme),
    thumbColor: thumbColor(colorScheme),
    overlayColor: overlayColor(colorScheme),
  );
}

MaterialStateProperty<Color?> trackColor(ColorScheme colorScheme) =>
    MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.onSecondary;
        }
        return null;
      },
    );

MaterialStateProperty<Color?> thumbColor(ColorScheme colorScheme) =>
    MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.onPrimary;
        }
        return null;
      },
    );

MaterialStateProperty<Color?> overlayColor(ColorScheme colorScheme) =>
    MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return colorScheme.onPrimary.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.onSurface.withOpacity(0.38);
      }
      return null;
    }
);
