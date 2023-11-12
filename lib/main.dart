import 'package:flutter/material.dart';
import 'package:zeromath/apps/home_page.dart';

import "constants/cores.constants.dart" as cores;

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: cores.primaryColor, background: cores.background),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
