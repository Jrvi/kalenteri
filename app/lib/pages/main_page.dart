import 'package:vapaat/pages/settings_page.dart';
import 'package:vapaat/pages/calender_page.dart';
import 'package:vapaat/widgets/freetime_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/navbar_widget.dart';
import 'package:vapaat/properties.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static const String _title = 'Kalenteri App';

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  //Screens from where the bar navigates
  static List<Widget> _widgetOptions = <Widget>[
    Freetime(),
    Calender(),
    SettingsPage(), //from here one can navigate to profile, groups, friends, etc
  ];

  //when the bar is clicked, the screen changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //Here something else, so that the app wont go over phone's upper edge
          //but there wont't be 'back' arrowbutton in main pages(free times, calender, settings)
          ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: OwnNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
