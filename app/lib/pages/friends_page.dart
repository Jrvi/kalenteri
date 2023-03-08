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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //vai onko tällä hyvä navigoida opis sivulta(eli ei navbaria alas vaan vain tämä?)
        title: Text('Kaverit'),
      ),
      body: ListView.builder(
        itemCount: _friendDataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_friendDataList[index].imagePath),
            ),
            title: Text(_friendDataList[index].name),
            subtitle: Text(_friendDataList[index].email),
            //kaverin poisto tällä painikkeella, tähän vielä joku lisävarmistus 'oletko varma'
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
    );
  }
}
