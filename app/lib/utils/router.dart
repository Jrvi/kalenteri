import 'package:app/pages/login.dart';
import 'package:app/pages/main_page.dart';
import 'package:app/pages/edit_profile.dart';
import 'package:app/pages/profile.dart';
import 'package:app/pages/rekisterointi.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/main':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MainPage(),
          );
        }
        return _errorRoute();
      case '/login':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
          );
        }
        return _errorRoute();
      case '/rekisterointi':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Rekisterointi(),
          );
        }
        return _errorRoute();
      case '/profile':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Profile(),
          );
        }
        return _errorRoute();
      case '/edit_profile':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => EditProfile(),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
