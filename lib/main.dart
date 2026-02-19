import 'dart:async';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {

    if (Firebase.apps.isEmpty) {

      await Firebase.initializeApp().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('[Firebase] Initialization timeout');
          throw TimeoutException('Firebase initialization timed out');
        },
      );
      print('[Firebase] Initialized successfully from Dart');
    }
  } catch (e) {
    print('[Firebase] Initialization failed: $e');

  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  static void setLocale(BuildContext context, Locale locale) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); 

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADCC Mobile App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,

      locale: _locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'), Locale('ar')],

      home: const SplashScreen(),
    );
  }
}
