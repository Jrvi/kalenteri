import 'package:app/pages/login.dart';
import 'package:app/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

/// Kalenteri apin main tiedosto
/// Käsittelee apin käynnistyksen ja navigoinnin
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Kalenteri_testi',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// Apin pääluokka
/// sisältää oletus teeman ja routerin navigointiin
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalenteri',
      initialRoute: '/',
      // router initial
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

/// Väliaikainen luokka alkunäkymälle, jonka avulla voi testata omia näkymiä
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required String title});
  static const String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
