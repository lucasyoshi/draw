import 'package:draw_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

// Light Theme
// final ThemeData lightTheme = ThemeData(
//   // brightness: Brightness.light,
//   primaryColor: const Color(0xFFFFFFFF), // Primary color
//   colorScheme: const ColorScheme.light(
//     primary: Color(0xFFFFFFFF), // Primary color
//     secondary: Color(0xFF2B323D), // Secondary color
//     tertiary: Color(0xFFE965BB), // Tertiary color
//     surface: Color(0xFF2B323D), // Fourth color
//     background: Color(0xFF000000), // Background color
//     onPrimary: Color(0xFF000000), // Text color on primary
//   ),
//   scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Fourth color
//   canvasColor: const Color(0xFF000000), // Fifth color

//   textButtonTheme:  TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: const Color(0xFFFFFFFF), // This is the text color
//       backgroundColor: const Color(0xFF2B323D), // This is the button color
//     ),
//   ),
//   fontFamily: 'Inter', // Primary font
//   textTheme: const TextTheme(
//     titleLarge:
//         TextStyle(fontFamily: 'Manrope'), // Secondary font for title large
//   ),
// );

// // Dark Theme
// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: const Color(0xFF000000), // Primary color
//   colorScheme: const ColorScheme.dark(
//     primary: Color(0xFF000000), // Primary color
//     secondary: Color(0xFFE965BB), // Secondary color
//     tertiary: Color(0xFF2B323D), // Tertiary color
//     surface: Color(0xFF2B323D), // Fourth color
//     background: Color(0xFF2B323D), // Background color
//     onPrimary: Color(0xFF2B323D), // Text color on primary
//   ),
//   scaffoldBackgroundColor: const Color(0xFF2B323D), // Fourth color
//   canvasColor: const Color(0xFF2B323D), // Fifth color

//   fontFamily: 'Inter', // Primary font
//   textTheme: const TextTheme(
//     titleLarge:
//         TextStyle(fontFamily: 'Manrope'), // Secondary font for title large
//   ),
// );

final ThemeData lightBase = ThemeData.light();

final ThemeData darkBase = ThemeData.light();

ThemeData buildLightTheme() {
  return lightBase.copyWith(
    colorScheme: lightColorScheme,
    // textTheme: buildTextTheme(base.textTheme),
    // iconTheme: buildIconTheme(base.iconTheme),
    // appBarTheme: buildAppBarTheme(base.appBarTheme),
    // textButtonTheme: buildTextButtonThemeData(base.textButtonTheme),
    // outlinedButtonTheme: buildOutlinedButtonThemeData(base.outlinedButtonTheme),
    // elevatedButtonTheme: buildElevatedButtonThemeData(base.elevatedButtonTheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    // switchTheme: buildSwitchTheme(base.switchTheme),
    // dialogTheme: buildDialogTheme(base.dialogTheme),
    // //inputDecorationTheme applies to TextField Widgets.
    // inputDecorationTheme: buildInputDecorationTheme(base.inputDecorationTheme),
    // //textSelectionTheme applies to the cursor of TextField Widgets.
    // textSelectionTheme: textSelectionThemeData(),
  );
}


ThemeData buildDarkTheme() {
  return lightBase.copyWith(
    // colorScheme: darkColorScheme,
    // textTheme: buildTextTheme(base.textTheme),
    // iconTheme: buildIconTheme(base.iconTheme),
    // appBarTheme: buildAppBarTheme(base.appBarTheme),
    // textButtonTheme: buildTextButtonThemeData(base.textButtonTheme),
    // outlinedButtonTheme: buildOutlinedButtonThemeData(base.outlinedButtonTheme),
    // elevatedButtonTheme: buildElevatedButtonThemeData(base.elevatedButtonTheme),
    // snackBarTheme: buildSnackBarTheme(base.snackBarTheme),
    // switchTheme: buildSwitchTheme(base.switchTheme),
    // dialogTheme: buildDialogTheme(base.dialogTheme),
    // //inputDecorationTheme applies to TextField Widgets.
    // inputDecorationTheme: buildInputDecorationTheme(base.inputDecorationTheme),
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
