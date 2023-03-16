import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vapaat/pages/allgroups_page.dart';
import 'package:vapaat/pages/models/localuser.dart';
import 'package:vapaat/pages/edit_profile.dart';
import 'package:vapaat/pages/friends_page.dart';
import 'package:vapaat/utils/user_preferences.dart';
import 'package:vapaat/utils/groups_preferences.dart';
import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final fakeuser = UserPreferences
      .getUser(); //since not yet real users with right info (name + picture), lets use fake data

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
                  imagePath: fakeuser.imagePath,
                  isEdit: false,
                  onClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                ),
                const SizedBox(width: 16.0),
                buildName(fakeuser),
              ],
            ),
            Divider(height: 32.0, thickness: 2.0),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 16.0),
                Text(friendlist_caption),
                Spacer(),
                ButtonWidget(
                  text: view_all,
                  onClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Friends()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(height: 32.0, thickness: 2.0),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 16.0),
                Text(grouplist_caption),
                Spacer(),
                ButtonWidget(
                  text: view_all,
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllGroups(
                                groups: GroupPreferences()
                                    .groups))); //now fake group data
                  },
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
