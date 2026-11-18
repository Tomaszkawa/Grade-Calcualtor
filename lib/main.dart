import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F6B5C),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Grade Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: base,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: base.primary,
          foregroundColor: base.onPrimary,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
