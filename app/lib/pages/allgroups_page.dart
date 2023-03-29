import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/group.dart';
import 'package:vapaat/pages/group_page.dart';
import 'package:vapaat/pages/create_group.dart';
import 'package:vapaat/properties.dart';
import 'package:vapaat/utils/database_utils.dart';

class AllGroups extends StatefulWidget {
  @override
  _AllGroupsState createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {
  List<Group> groups = [];

  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  Future<void> _getGroups() async {
    final List<Group> groupsList = await DatabaseUtil.getGroups();
    print('Fetched groups: $groupsList');
    setState(() {
      groups = groupsList;
    });
  }

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
              thumbVisibility: true, // make scrollbar always visible
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
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
            onPressed: () async {
              final bool groupCreated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateGroup(),
                ),
              );
              if (groupCreated != null && groupCreated) {
                _getGroups(); // Päivitä ryhmät, kun ryhmä on luotu
              }
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
