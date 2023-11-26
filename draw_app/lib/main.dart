// ignore_for_file: library_private_types_in_public_api

import 'package:draw_app/views/auth_gate.dart';
import 'package:draw_app/theme/theme.dart';
import 'package:draw_app/views/products_page.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// Firebase Imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Draw',
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      // home: AuthGate(),
      home: const ProductsPage()
      // home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Content Here'),
          ],
        ),
      ),
    );
  }
}

// class ThemeManager {
//   static void changeTheme(BuildContext context, ThemeMode newTheme) {
//     // Set the new theme and rebuild the widget tree
//     MaterialApp? app = context.findAncestorWidgetOfExactType<MaterialApp>();
//     app!.onGenerateRoute = app.onGenerateRoute; // Ensure rebuild
//     app.themeMode = newTheme;
//   }
// // }

// class ThemeManager extends StatefulWidget {
//   final Widget child;
//   final ThemeMode initialTheme;

//   const ThemeManager(
//       {Key? key, required this.child, required this.initialTheme})
//       : super(key: key);

//   static _ThemeManagerState? of(BuildContext context) {
//     return context.findAncestorStateOfType<_ThemeManagerState>();
//   }

//   @override
//   _ThemeManagerState createState() => _ThemeManagerState();
// }

// class _ThemeManagerState extends State<ThemeManager> {
//   late ThemeMode _themeMode;

//   @override
//   void initState() {
//     super.initState();
//     _themeMode = widget.initialTheme;
//   }

//   void changeTheme(ThemeMode newTheme) {
//     setState(() {
//       _themeMode = newTheme;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       themeMode: _themeMode,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: widget.child,
//     );
//   }
// }
