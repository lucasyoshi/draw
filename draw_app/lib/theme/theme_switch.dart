import 'package:draw_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});
  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );
  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbIcon: thumbIcon,
      value: Provider.of<ThemeNotifier>(context).isDarkTheme,
      onChanged: (bool value) {
        setState(() {
          Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
        });
      },
    );
  }
}
