import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/friends_preference.dart';
import 'package:vapaat/properties.dart';
import 'package:vapaat/widgets/freetime_widget.dart';
import 'package:vapaat/pages/settings_page.dart';
import 'dart:io';
import 'package:vapaat/widgets/button_widget.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<Friend> _friendDataList = friendDataList;
  final _scrollController = ScrollController();
  int _selectedIndex = 0;
  //Screens from where the bar navigates (copy from main-page)
  static List<Widget> _widgetOptions = <Widget>[
    Freetime(),
    Text('Todo: calender, add/delete events'),
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
          friend_caption,
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              itemCount: _friendDataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(_friendDataList[index].imagePath),
                  ),
                  title: Text(_friendDataList[index].name),
                  subtitle: Text(_friendDataList[index].email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _friendDataList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ButtonWidget(
                //color: Theme.of(context).colorScheme.primary,
                onClicked: () {},
                //TODO: add new friend
                text: friend_add,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: OwnNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
