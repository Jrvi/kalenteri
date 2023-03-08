import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/pages/models/group.dart';
import 'package:app/utils/groups_preferences.dart';

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
      body: Container(
        height: 600,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),

            //Sivun otsikko
            Text(
              //vai appbar?
              "Ryhmät",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 44),

            //Ryhmien lista
            ListView.builder(
              shrinkWrap:
                  true, //koko muuttuu sen mukaan, kuinka monta ryhmää on
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                final group = widget.groups[index];
                return ListTile(
                  title: Text(group.name),
                  subtitle: Text("Jäsenet: ${group.members.join(', ')}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
