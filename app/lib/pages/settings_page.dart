import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/localUser.dart';
import 'package:vapaat/utils/friends_preference.dart';
import 'package:vapaat/utils/user_preferences.dart';
import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/utils/database_utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final fakeuser = UserPreferences.getUser();
  List<Friend> _friendDataList = [];
  final _scrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchList();
    });
  }

//Fetches users friends from database
// And does it each time this page is opened. TODO: Might want to change that.
  Future<void> fetchList() async {
    _friendDataList = await DatabaseUtil.getFriends();
    setState(() {});
  }

//Add friend dialog, which will show when user pushes 'Add new friend' floating button and witch will add new friend to database
  Future addFriendDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    nameController
        .clear(); // empty the text field everytime the addFriendDialog is opened
    emailController.clear();

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(friend_new),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: friend_name,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    nameController.clear();
                    emailController.clear();
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    final name = nameController.text;
                    final email = emailController.text;
                    Friend newFriend = Friend(name: '', email: '');

                    // Checking if there is an account tied to given email
                    // fetchSignInMethodsForEmail returns an array with sign-in methods the given email has
                    bool accountExists;
                    try {
                      accountExists = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(email)
                          .then((value) {
                        return value.isNotEmpty;
                      });
                    } on FirebaseAuthException {
                      accountExists = false;
                    }

                    // Checking if the name is correct and if so, uses the queried user as the "newFriend"
                    // Database is being queried only once for the (possible) friend details (I think)
                    bool namesMatch = false;
                    if (accountExists) {
                      newFriend = await DatabaseUtil.getUserByEmail(email);
                      namesMatch =
                          name.toLowerCase() == newFriend.name.toLowerCase();
                    }

                    // Error messages with SnackBar
                    if (accountExists || !namesMatch) {
                      final error =
                          SnackBar(content: Text(wrong_name_or_email));
                      ScaffoldMessenger.of(context).showSnackBar(error);
                    }

                    // Check if name and email are not empty and if not, adds friend
                    if (name.isNotEmpty &&
                        email.isNotEmpty &&
                        accountExists &&
                        namesMatch) {
                      DatabaseUtil.addFriend(newFriend);
                      nameController.clear();
                      emailController.clear();
                      fetchList();
                      Navigator.pop(context, 'OK');
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            ));
  }

  // Handling the back button
  DateTime currentBackPressTime = DateTime.now();
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      final confirm = SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('Press back again to exit'));
      ScaffoldMessenger.of(context).showSnackBar(confirm);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(onWillPop());
      },
      child: Scaffold(
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
                              Navigator.popUntil(
                                  context,
                                  (Route<dynamic> predicate) =>
                                      predicate.isFirst)
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
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                        title: Text(_friendDataList[index].name),
                        subtitle: Text(_friendDataList[index].email),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            String? friendID = _friendDataList[index].uid;
                            DatabaseUtil.deleteFriend(friendID);
                            fetchList();
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
                  Center(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        addFriendDialog();
                      },
                      label: const Text(friend_add),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
