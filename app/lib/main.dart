import 'package:firebase_auth/firebase_auth.dart';
import 'package:vapaat/pages/login.dart';
import 'package:vapaat/pages/profile.dart';
import 'package:vapaat/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
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
      // router initial
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        useMaterial3: true, //toimiiko?
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            //primary: Colors.yellow,
            seedColor: Color(0x00006a60)),
      ),
      home: const MyHomePage(title: 'Vapaat'),
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
    //Tämän takia vain loginiin teema, muilla sivuilla ei toimi. Korjattava
  }
}
