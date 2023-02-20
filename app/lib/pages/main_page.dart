import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalenteri'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('nappula :D'),
        ),
      ),
      bottomSheet: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/profile', arguments: 'profile');
            },
            child: const Text('profiili')),
      ),
    );
  }
}
