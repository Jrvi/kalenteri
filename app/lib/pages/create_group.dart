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
  List<Friend> _friends = [];

  @override
  void initState() {
    _friends = getFriends();
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
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
            "Lisää jäseniä",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          SizedBox(height: 34),

          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Kirjoita kaverin nimi',
              suffixIcon: Icon(Icons.search),
            ),
          ),

          //SizedBox(height: 24),

          SizedBox(
            height: 300,
            child: _friends.length > 4
                ? Scrollbar(
                    controller: _scrollController,
                    isAlwaysShown: true,
                    child: ListView.builder(
                      itemCount: _friends.length,
                      itemBuilder: (context, index) {
                        final friend = _friends[index];
                        return ListTile(
                          title: Text(friend.name),
                          onTap: () {
                            // TODO: Implement selecting friend functionality
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
