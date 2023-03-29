import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/allgroups_page.dart';
import 'package:vapaat/utils/listfriends_preference.dart';
import 'package:vapaat/properties.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _selectedFriendsScrollController = ScrollController();
  List<Friend> _friends = [];
  List<String> _selectedFriends = [];

  final DatabaseReference _groupRef =
      FirebaseDatabase.instance.ref().child("groups");

  @override
  void initState() {
    _friends = getFriends();
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _selectedFriendsScrollController.dispose();
    super.dispose();
  }

  void _addFriendToSelected(String friendName) {
    setState(() {
      _selectedFriends.add(friendName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          create_group,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: create_name,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 34),

          Text(
            create_members,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          SizedBox(height: 24),

          //valitut kaverit, nyt scrollaantuu horisontaalisesti, korjattava
          Container(
            height: 30,
            child: ListView.builder(
              controller: _selectedFriendsScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _selectedFriends.length,
              itemBuilder: (context, index) {
                final friendName = _selectedFriends[index];
                return Chip(
                  label: Text(friendName),
                  deleteIcon: Icon(Icons.cancel),
                  onDeleted: () {
                    setState(() {
                      _selectedFriends.remove(friendName);
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 24),

          //kaverilista
          SizedBox(
            height: 200,
            //jos kavereita enemmän kuin 4, scrollattava alue
            child: _friends.length > 6
                ? Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: _friends.length,
                      itemBuilder: (context, index) {
                        final friend = _friends[index];
                        //Kaverin kuva näkyviin
                        return ListTile(
                          title: Text(friend.name),
                          onTap: () {
                            // TODO: Implement selecting friend functionality
                            _addFriendToSelected(friend.name);
                          },
                        );
                      },
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _friends.length,
                    itemBuilder: (context, index) {
                      final friend = _friends[index];
                      return ListTile(
                        title: Text(friend.name), //kaverin kuva näkyviin?
                        onTap: () {
                          // TODO: Implement selecting friend functionality
                          _addFriendToSelected(friend.name);
                        },
                      );
                    },
                  ),
          ),
          SizedBox(height: 105),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  //TODO: skip painikkeelle toiminnot; hylkää jos ryhmälle on jo nimi ja jäsenet?
                },
                child: Text(create_cancel),
              ),
              SizedBox(width: 64),
              SizedBox(
                height: 40, // add a fixed height to give space for the button
                child: ElevatedButton(
                  onPressed: () {
                    String groupName = _groupNameController.text;
                    List<String> members = _selectedFriends;
                    if (groupName.isNotEmpty && members.isNotEmpty) {
                      _groupRef.push().set({
                        'name': groupName,
                        'members': members,
                      }).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Group created successfully')),
                        );
                        Navigator.pop(context,
                            true); // Palauta arvo "true", kun ryhmä on luotu
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      });
                    }
                  },
                  child: Text(create_save),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
