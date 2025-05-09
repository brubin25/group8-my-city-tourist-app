import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const ThunderBayToursApp());

class ThunderBayToursApp extends StatelessWidget {
  const ThunderBayToursApp({super.key});
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Thunder Bay Tours',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
