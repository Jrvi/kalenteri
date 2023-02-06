import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigation
          },
          child: const Text('nappula :D'),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
