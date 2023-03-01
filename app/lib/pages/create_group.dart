import 'package:flutter/material.dart';
import 'package:app/utils/friends_preferences.dart';
import 'dart:io';

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
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),

          //Sivun otsikko
          Text(
            "Luo ryhmä",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 44),

          SizedBox(
            width: 300,
            child: TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Ryhmän nimi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          SizedBox(height: 34),

          Text(
            "Lisää kavereita",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          SizedBox(height: 24),

          //valitut kaverit, nyt scrollaantuu horisontaalisesti, korjattava
          Container(
            height: 50,
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

          //hakukenttä, ei vielä toimintoa
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Kirjoita kaverin nimi',
              suffixIcon: Icon(Icons.search),
            ),
          ),

          //kaverilista
          SizedBox(
            height: 300,
            //jos kavereita enemmän kuin 4, scrollattava alue
            child: _friends.length > 4
                ? Scrollbar(
                    controller: _scrollController,
                    isAlwaysShown: true,
                    child: ListView.builder(
                      itemCount: _friends.length,
                      itemBuilder: (context, index) {
                        final friend = _friends[index];

                        //Kaverin kuva näkyviin
                        return ListTile(
                          title: Text(friend.name),
                          onTap: () {
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
                          _addFriendToSelected(friend.name);
                        },
                      );
                    },
                  ),
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  //TODO: skip painikkeelle toiminnot; hylkää jos ryhmälle on jo nimi ja jäsenet?
                },
                child: Text('Peruuta'),
              ),
              SizedBox(width: 64),
              ElevatedButton(
                onPressed: () {
                  //TODO: Luo ryhmä ja tallennsa se
                  String groupName = _groupNameController.text;
                  print('Luodaan ryhmä: $groupName');
                },
                child: Text('Luo ryhmä'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
