import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(const ThunderBayToursApp());

class ThunderBayToursApp extends StatelessWidget {
  const ThunderBayToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thunder Bay Tours',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
