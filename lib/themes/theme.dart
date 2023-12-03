import 'package:flutter/material.dart';
import 'package:zeromath/constants/cores.constants.dart' as cores;

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: cores.background,
    primary: cores.primaryColor,
    secondary: cores.babyBlue,
    tertiary: Colors.white
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      background: cores.backgroundDark, 
      primary: cores.primaryColorDark, 
      secondary: cores.babyBlueDark,
      tertiary: cores.backgroundDark),
);
