import 'package:app/widgets/profile_widget.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/models/user.dart';
import 'package:app/pages/edit_profile.dart';
import 'package:app/utils/user_preferences.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
  final user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          //Sivun otsikko
          Text(
            "Profiili",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 44),

          //Profiilikuva
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: false,
            onClicked: () {
              Navigator.of(context)
                  .pushNamed('/edit_profile', arguments: 'edit_profile');
            },
          ),

          const SizedBox(height: 24),

          //Nimi ja spo
          buildName(user),

          const SizedBox(height: 64),

          Center(
            child: ButtonWidget(
              text: 'Lisää kalenteri',
              onClicked: () {},
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ButtonWidget(
              text: 'Lisää menemisiä',
              onClicked: () {},
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ButtonWidget(
              text: 'Poista menemisiä',
              onClicked: () {},
            ),
          ),
        ],
      ),
    );
  }

//Metodi: profiilin omistajan nimi ja spo (jos on => salasanan palautus)
  Widget buildName(User user) => Column(
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
