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
  late ScrollController _scrollController;
  late ScrollController _listViewController; // <-- add this line

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: group.name);
    _scrollController = ScrollController();
    _listViewController = ScrollController(); // <-- add this line
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    _listViewController.dispose(); // <-- add this line
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
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 34),

          //Sivun otsikko
          Text(
            group.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Muokkaa nimeä',
            ),
            onChanged: _updateGroupName,
          ),

          const SizedBox(height: 34),

          Text(
            'Jäsenet',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(
            height: 200,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _listViewController, // <-- use the new controller
                itemCount: group.members.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //kuva puuttuu
                    title: Text(group.members[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
