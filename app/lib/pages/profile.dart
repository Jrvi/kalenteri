import 'package:app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/models/user.dart';
import 'package:app/utils/user_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser; //vai final?

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(), //turha rivi?
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            //Kuvaa klikattaessa sitä voidaan muokata
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
        ],
      ),
    );
  }

//Metodi: profiilin omistajan nimi
  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
        ],
      );
}
