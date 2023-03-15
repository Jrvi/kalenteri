import 'package:flutter/material.dart';

class OwnNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const OwnNavBar(
      {Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.date_range),
          label: 'Free times',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle),
          label: 'Calender',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}
