import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/properties.dart';

class FriendsPage extends StatefulWidget {
  @override
  FriendsState createState() => FriendsState();

  static void friendsUpdate() {
    FriendsState.fetchList();
  }
}

class FriendsState extends State<FriendsPage> {
  static List<Friend> _friendDataList = [];
  final _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchList();
    });
  }

  static Future fetchList() async {
    _friendDataList = await DatabaseUtil.getFriends();
  }

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
                    );

                    DatabaseReference db = database.ref().child('users/');

                    // Querying for the correct user using their email address
                    // Returns a DataSnapshot
                    // Could be in database_utils
                    DataSnapshot snapshot =
                        await db.orderByChild('email').equalTo(email).get();

                    String? friendUID = snapshot.children.first.key;

                    DatabaseUtil.addFriend(newFriend, friendUID);
                    _nameController.clear();
                    _emailController.clear();
                    fetchList();
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
            child: RefreshIndicator(
              onRefresh: fetchList,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10),
                physics: BouncingScrollPhysics(),
                itemCount: _friendDataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'),
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
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
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
