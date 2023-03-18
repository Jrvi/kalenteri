import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/friends_preference.dart';
import 'package:vapaat/properties.dart';
import 'package:vapaat/widgets/freetime_widget.dart';
import 'package:vapaat/widgets/filledbutton_widget.dart';
import 'package:vapaat/pages/settings_page.dart';
import 'dart:io';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<Friend> _friendDataList = friendDataList;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          app_name,
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
              FloatingActionButton.extended(
                onPressed: () {
                  //todo
                },
                label: const Text(friend_add),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 44),
        ],
      ),
    );
  }
}
