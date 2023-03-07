import 'package:app/pages/models/group.dart';
import 'package:app/utils/group_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final group = GroupPreferences.modelgroup;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: group.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateGroupName(String name) {
    setState(() {
      group.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Ryhmän nimi',
                border: OutlineInputBorder(),
              ),
              onChanged: _updateGroupName,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Jäsenet',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: group.members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(group.members[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
