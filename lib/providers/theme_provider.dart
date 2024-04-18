import 'package:flutter/material.dart';
import 'package:zeromath/themes/themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    themeData.brightness == Brightness.light
        ? themeData = darkTheme
        : themeData = lightTheme;
  }
}
