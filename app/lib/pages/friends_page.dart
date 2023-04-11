import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/friends_preference.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/properties.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<Friend> _friendDataList = friendDataList;
  final _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final user = FirebaseAuth.instance.currentUser!;

  Future addFriendDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(friend_new),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: friend_name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: friend_email,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _nameController.clear();
                  _emailController.clear();
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  final name = _nameController.text;
                  final email = _emailController.text;

                  // Checking if there is an account tied to given email
                  // fetchSignInMethodsForEmail returns an array with sign-in methods the given email has
                  // TODO: Error messages for when user gives a wrong email address (and maybe put this in database_utils)
                  var accountExists = await FirebaseAuth.instance
                      .fetchSignInMethodsForEmail(email)
                      .then((value) {
                    return value.isNotEmpty;
                  });

                  // Check if name and email are not empty and if not, adds friend
                  if (name.isNotEmpty && email.isNotEmpty && accountExists) {
                    Friend newFriend = Friend(
                      name: name,
                      email: email,
                      imagePath:
                          'https://picsum.photos/200?random=${email.hashCode}', //now just a random phoot, in the future use friend's profile picture
                    );
                    DatabaseUtil.addFriend(newFriend);
                    _nameController.clear();
                    _emailController.clear();
                    Navigator.pop(context, 'OK');
                  }
                },
                child: Text('OK'),
              ),
            ],
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          app_name,
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              itemCount: _friendDataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(_friendDataList[index].imagePath),
                  ),
                  title: Text(_friendDataList[index].name),
                  subtitle: Text(_friendDataList[index].email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _friendDataList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              FilledButton(
                  onPressed: () async {
                    print('Eeee ${user.uid}');

                    DatabaseReference db =
                        database.ref().child('users/${user.uid}/friends');
                    // For reasons I don't know, putting ".value" after db.get() doesn't work
                    // await db.get();
                    // print('Jotain ${await db.get()}');

                    // Assigning it first seems to work fine, though
                    DataSnapshot snapshot = await db.get();
                    print('Jotain ${snapshot.value}');

                    // Finally figured out how to get something out of our database!!!!!!
                    print('Childrenn: ${snapshot.children}');
                    for (DataSnapshot avain in snapshot.children) {
                      print('Nimi: ${avain.child('name').value}');
                    }
                  },
                  child: const Text('Reeeeeeeee')),
              FloatingActionButton.extended(
                onPressed: () {
                  addFriendDialog();
                },
                label: const Text(friend_add),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 44),
        ],
      ),
    );
  }
}
