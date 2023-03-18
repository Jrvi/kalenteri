import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/group.dart';
import 'package:vapaat/pages/group_page.dart';
import 'package:vapaat/pages/create_group.dart';
import 'package:vapaat/properties.dart';
import 'package:vapaat/utils/groups_preferences.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/widgets/filledbutton_widget.dart';

class AllGroups extends StatefulWidget {
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
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Scrollbar(
              isAlwaysShown: true, // make scrollbar always visible
              child: ListView.builder(
                itemCount: widget.groups.length,
                itemBuilder: (context, index) {
                  final group = widget.groups[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupPage(
                                group: group,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                group.members.length <= 10
                                    ? group_members +
                                        ': ${group.members.join(", ")}'
                                    : group_members +
                                        ': ${group.members.take(10).join(", ")} ...',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 34),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateGroup(),
                ),
              );
            },
            label: const Text(add_group),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 54),
        ],
      ),
    );
  }
}
