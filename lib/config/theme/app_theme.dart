import 'package:flutter/material.dart';

final List<Color> colors = [
  Colors.red,
  Colors.redAccent,
  Colors.lightBlueAccent,
  Colors.teal,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.green,
  Colors.lightGreen,
  Colors.tealAccent
];


class AppTheme{
  final int selectedColor;
  final bool isDarkMode;

  const AppTheme({this.selectedColor = 0, this.isDarkMode = false});


  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: colors[selectedColor],
    brightness: _getBrightness(),
    useMaterial3: true,
    typography: Typography.material2021()
  );

  Brightness _getBrightness() => isDarkMode ? Brightness.dark : Brightness.light;
}