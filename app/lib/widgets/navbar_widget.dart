import 'package:flutter/material.dart';

class OwnNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  OwnNavigationBar({required this.currentIndex, required this.onTap});

  @override
  State<StatefulWidget> createState() => _OwnNavigationBarState();
}

class _OwnNavigationBarState extends State<OwnNavigationBar> {
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
          label: 'Calendar', // calendar view from where to add/delete events
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: widget.onTap,
    );
  }
}
