import 'package:vapaat/pages/profile.dart';
import 'package:vapaat/pages/allgroups_page.dart';
import 'package:vapaat/pages/settings_page.dart';
import 'package:vapaat/utils/groups_preferences.dart';
import 'package:vapaat/widgets/freetime_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/navbar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String _title = 'Kalenteri App';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Freetime(),
    Profile(),
    AllGroups(groups: GroupPreferences().groups),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App's name",
          textAlign: TextAlign.center, // not aligning right yet
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: OwnNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
