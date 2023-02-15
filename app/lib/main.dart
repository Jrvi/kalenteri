import 'package:app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Kalenteri apin main tiedosto
/// Käsittelee apin käynnistyksen ja navigoinnin
void main() {
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
        '/mainpage': (context) => MainPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testi'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/mainpage');
          },
          child: const Text('testi'),
        ),
      ),
    );
  }
}
