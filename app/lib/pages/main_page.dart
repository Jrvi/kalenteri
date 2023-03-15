import 'package:vapaat/pages/settings_page.dart';
import 'package:vapaat/widgets/freetime_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/navbar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
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
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  //Screens from where the bar navigates
  static List<Widget> _widgetOptions = <Widget>[
    Freetime(),
    Text('Todo: calender, add/delete events'),
//    AllGroups(groups: GroupPreferences().groups),
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
        title: Text(
          "App's name",
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
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
