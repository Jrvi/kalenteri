import 'package:app/pages/models/group.dart';
import 'package:app/utils/group_preferences.dart';
import 'package:app/widgets/button_widget.dart';
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
  late ScrollController _listViewController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: group.name);
    _scrollController = ScrollController();
    _listViewController = ScrollController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    _listViewController.dispose();
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

          const SizedBox(height: 34),

          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Muokkaa nimeä',
            ),
            onChanged: _updateGroupName,
          ),

          const SizedBox(height: 54),

          Text(
            'Jäsenet',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(
            height: 300,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _listViewController,
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

          const SizedBox(height: 34),

          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () {},
                child: Text('Lisää jäseniä'),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: Text('Poistu ryhmästä'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
