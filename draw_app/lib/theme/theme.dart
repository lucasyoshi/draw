import 'package:draw_app/theme/color_scheme.dart';
import 'package:draw_app/theme/input_decoration.dart';
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
    // textButtonTheme: buildTextButtonThemeData(base.textButtonTheme),
    // outlinedButtonTheme: buildOutlinedButtonThemeData(base.outlinedButtonTheme),
    // elevatedButtonTheme: buildElevatedButtonThemeData(base.elevatedButtonTheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    // switchTheme: buildSwitchTheme(base.switchTheme),
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
    // textButtonTheme: buildTextButtonThemeData(base.textButtonTheme),
    // outlinedButtonTheme: buildOutlinedButtonThemeData(base.outlinedButtonTheme),
    // elevatedButtonTheme: buildElevatedButtonThemeData(base.elevatedButtonTheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    // switchTheme: buildSwitchTheme(base.switchTheme),
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
