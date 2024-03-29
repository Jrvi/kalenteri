import 'package:flutter/material.dart';
import 'package:vapaat/properties.dart';

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
          icon: Icon(Icons.access_time),
          label: navBar_time,
        ),
        NavigationDestination(
          icon: Icon(Icons.date_range),
          label: navBar_calender,
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: navBar_profile,
        ),
      ],
    );
  }
}
