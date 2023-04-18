import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/allgroups_page.dart';
import 'package:vapaat/pages/models/localUser.dart';
import 'package:vapaat/pages/friends_page.dart';
import 'package:vapaat/utils/user_preferences.dart';
import 'package:vapaat/utils/groups_preferences.dart';
import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/database_utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();

  static void friendsUpdate() {
    FriendsState.fetchList();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  final fakeuser = UserPreferences
      .getUser(); //since not yet real users with right info (name + picture), lets use fake data
  static List<Friend> _friendDataList = [];
  final _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    FriendsPage.friendsUpdate();
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
                    SettingsPage.friendsUpdate();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileWidget(
                  isEdit: false,
                ),
                const SizedBox(width: 16.0),
                buildName(fakeuser),
                Spacer(),
                ButtonWidget(
                    onClicked: () {
                      FirebaseAuth.instance.signOut().then((value) => {
                            log("signed out"),
                            Navigator.popUntil(context,
                                (Route<dynamic> predicate) => predicate.isFirst)
                          });
                    },
                    text: logout),
              ],
            ),
            Divider(height: 32.0, thickness: 2.0),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 16.0),
                Text(friendlist_caption, style: TextStyle(fontSize: 20)),
                Spacer(),
              ],
            ),
            const SizedBox(height: 4),
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
          ],
        ),
      ),
    );
  }

  //User's name and email
  Widget buildName(LocalUser user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
