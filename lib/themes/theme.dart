import 'package:flutter/material.dart';
import 'package:zeromath/constants/cores.constants.dart' as cores;

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: cores.mainColorLight,
    primary: cores.accentColorLight,
    secondary: cores.secondaryColorLight,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: cores.mainColorDark,
    primary: cores.accentColorDark,
    secondary: cores.secondaryColorDark,
  ),
);
