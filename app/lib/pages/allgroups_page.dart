import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/group.dart';
import 'package:vapaat/pages/group_page.dart';
import 'package:vapaat/properties.dart';
import 'package:vapaat/utils/groups_preferences.dart';
import 'package:vapaat/widgets/button_widget.dart';

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
      appBar: AppBar(
        title: Text(
          all_groups_caption,
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 34),

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

          ButtonWidget(text: add_group, onClicked: () {}),

          const SizedBox(height: 34),
        ],
      ),
    );
  }
}
