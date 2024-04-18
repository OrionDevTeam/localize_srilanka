import 'package:flutter/material.dart';
import 'package:localize_sl/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localize Sri Lanka',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A966C),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

