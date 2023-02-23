import 'package:app/widgets/profile_widget.dart';
import 'package:app/widgets/textfield_widget.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/models/user.dart';
import 'package:app/utils/user_preferences.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          //Sivun otsikko
          Text(
            "Muokkaa profiilia",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 44),

          //Profiilikuva
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),

          const SizedBox(height: 24),

          //Nimi ja muokkaaminen
          TextFieldWidget(
            label: 'Nimi',
            text: user.name,
            onChanged: (name) {},
          ),

          const SizedBox(height: 24),

          //Salasana ja muokkaaminen
          TextFieldWidget(
            label: 'Salasana',
            text: user.name, //mustia palloja?
            onChanged: (name) {},
          ),

          const SizedBox(height: 44),

          ButtonWidget(
            text: 'Lisää kalenteri',
            onClicked: () {},
          ),

          const SizedBox(height: 24),

          ButtonWidget(
            text: 'Muokkaa menemisiä',
            onClicked: () {},
          ),
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
