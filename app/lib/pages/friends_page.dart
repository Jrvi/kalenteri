import 'package:flutter/material.dart';
import 'package:app/pages/models/friend.dart';
import 'package:app/utils/friends_preference.dart';
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
          const SizedBox(height: 34),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                //TODO: toiminto, joka lisää uuden kaverin
                onPressed: () {},
                child: Text('Lisää uusi kaveri'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
