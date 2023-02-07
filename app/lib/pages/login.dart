import 'package:flutter/material.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String _title = 'Login Page =)';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Kalenteriappi Login Page')),
          body: const MyStatefulWidget(
            title: _title,
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});

  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidget();
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
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
                  'LOGO PLACEHOLDER',
                  style: TextStyle(
                      color:
                          Colors.blue, // Teema vois olla kätevä saada toimimaan
                      // color: Theme.of(context).colorScheme.primaryContainer,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
