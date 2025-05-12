import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(const ThunderBayToursApp());

class ThunderBayToursApp extends StatefulWidget {
  const ThunderBayToursApp({super.key});

  @override
  State<ThunderBayToursApp> createState() => _ThunderBayToursAppState();
}

class _ThunderBayToursAppState extends State<ThunderBayToursApp> {
  Locale _locale = const Locale('en');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thunder Bay Tours',
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(onLocaleChange: _setLocale),
    );
  }
}