import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Flutter Demo Home Page')),
          body: const LoginPage(
            title: 'Login page =)',
          ),
        ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController postiController = TextEditingController();
  TextEditingController salasanaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: postiController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sähköposti (tai käyttäjänimi)',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: salasanaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Salasana',
                ),
              ),
            ),
            Row(
              children: <Widget>[
                const Text('No account?'),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            )
          ],
        ));
  }
}
