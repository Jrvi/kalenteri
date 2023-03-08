import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/pages/models/group.dart';
import 'package:app/pages/group_page.dart';
import 'package:app/utils/groups_preference.dart';

class AllGroups extends StatefulWidget {
  //vai stateless?
  final List<Group> groups;

  AllGroups({required this.groups});

  @override
  _AllGroupsState createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),

          //Sivun otsikko
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              //vai appbar?
              "Ryhmät",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 44),

          //Ryhmien lista
          Expanded(
            child: ListView.builder(
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                final group = widget.groups[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupPage(
                            group:
                                group), //tähän se ryhmä, jonka sivua halutaan katsoa                      ),
                      ),
                    );
                  },
                  child: ListTile(
                    //ryhmän nimi näkyviin
                    title: Text(group.name),
                    //jäsenet näkyviin
                    subtitle: Text("Jäsenet: ${group.members.join(', ')}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
