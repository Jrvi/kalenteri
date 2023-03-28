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

  @override
  void initState() {
    super.initState();
    fetchList();
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
                onPressed: () {
                  final name = _nameController.text;
                  final email = _emailController.text;

                  // Check if name and email are not empty and if not, adds friend
                  if (name.isNotEmpty && email.isNotEmpty) {
                    Friend newFriend = Friend(
                      name: name,
                      email: email,
                      imagePath:
                          'https://picsum.photos/200?random=${email.hashCode}', //now just a random photo, in the future use friend's profile picture
                    );
                    DatabaseUtil.addFriend(newFriend);
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
