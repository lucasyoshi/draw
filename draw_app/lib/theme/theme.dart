import 'package:draw_app/theme/button.dart';
import 'package:draw_app/theme/color_scheme.dart';
import 'package:draw_app/theme/input_decoration.dart';
import 'package:draw_app/theme/switch.dart';
import 'package:draw_app/theme/text.dart';
import 'package:flutter/material.dart';

final ThemeData lightBase = ThemeData.light();

final ThemeData darkBase = ThemeData.light();

ThemeData buildLightTheme() {
  return lightBase.copyWith(
    colorScheme: lightColorScheme,
    textTheme: lightText(lightBase.textTheme),
    // iconTheme: buildIconTheme(base.iconTheme),
    // appBarTheme: buildAppBarTheme(base.appBarTheme),
    textButtonTheme: buildTextButtonThemeData(lightBase.textButtonTheme, lightColorScheme),
    outlinedButtonTheme: buildOutlinedButtonThemeData(lightBase.outlinedButtonTheme, lightColorScheme),
    elevatedButtonTheme: buildElevatedButtonThemeData(lightBase.elevatedButtonTheme, lightColorScheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    switchTheme: switchTheme(lightBase.switchTheme, lightColorScheme),
    // dialogTheme: buildDialogTheme(base.dialogTheme),
    // //inputDecorationTheme applies to TextField Widgets.
    inputDecorationTheme: lightInputDecoration(
        lightBase.inputDecorationTheme, lightBase.textTheme),
    // //textSelectionTheme applies to the cursor of TextField Widgets.
    // textSelectionTheme: textSelectionThemeData(),
  );
}

ThemeData buildDarkTheme() {
  return lightBase.copyWith(
    colorScheme: darkColorScheme,
    textTheme: darkText(darkBase.textTheme),
    // iconTheme: buildIconTheme(base.iconTheme),
    // appBarTheme: buildAppBarTheme(base.appBarTheme),
    textButtonTheme: buildTextButtonThemeData(darkBase.textButtonTheme, darkColorScheme),
    outlinedButtonTheme: buildOutlinedButtonThemeData(darkBase.outlinedButtonTheme, darkColorScheme),
    elevatedButtonTheme: buildElevatedButtonThemeData(darkBase.elevatedButtonTheme, darkColorScheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    switchTheme: switchTheme(darkBase.switchTheme, darkColorScheme),
    // dialogTheme: buildDialogTheme(base.dialogTheme),
    // //inputDecorationTheme applies to TextField Widgets.
    inputDecorationTheme:
        darkInputDecoration(darkBase.inputDecorationTheme, darkBase.textTheme),
    // //textSelectionTheme applies to the cursor of TextField Widgets.
    // textSelectionTheme: textSelectionThemeData(),
  );
}

class ThemeNotifier extends ChangeNotifier {
  final ThemeData lightTheme = buildLightTheme();
  final ThemeData darkTheme = buildDarkTheme();
  late ThemeData _currentTheme;

  ThemeNotifier() {
    // Set the initial theme
    _currentTheme = lightTheme;
  }
  ThemeData get currentTheme => _currentTheme;
  bool get isDarkTheme => _currentTheme == darkTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
