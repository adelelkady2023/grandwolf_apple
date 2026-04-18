import 'package:flutter/material.dart';

void main() {
  runApp(const GrandWolfApp());
}

class GrandWolfApp extends StatelessWidget {
  const GrandWolfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grand Wolf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E1A2A),
          primary: const Color(0xFF0E1A2A),
          secondary: const Color(0xFFC5A059),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Grand Wolf Flutter App'),
        ),
      ),
    );
  }
}
