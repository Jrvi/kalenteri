import 'package:flutter/material.dart';

class OwnNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  OwnNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.date_range),
          label: 'Free times',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Calender', // calender view from where to add/delete events
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: onTap,
    );
  }
}
