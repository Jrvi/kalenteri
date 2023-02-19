
import 'package:app/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';

/// Kalenteri apin main tiedosto
/// Käsittelee apin käynnistyksen ja navigoinnin
Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
      routes: {
        '/mainpage': (context) => const MainPage(),
        '/loginpage': (context) => const LoginPage(),
        '/profilepage': (context) => const Profile(),
      },
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testi'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/loginpage');
          },
          child: const Text('testi'),
        ),
      ),
    );
  }

//Profiilinäkymä
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Profile(),
    );
  }
}
