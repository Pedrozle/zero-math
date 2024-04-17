import 'package:flutter/material.dart';
import 'package:zeromath/apps/home_page.dart';
import 'package:zeromath/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zer0Math',
      theme: lightMode,
      darkTheme: darkMode,
      home: const HomePage(),
    );
  }
}
