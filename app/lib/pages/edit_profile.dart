import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/textfield_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/localuser.dart';
import 'package:vapaat/utils/user_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  LocalUser user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),

          //Sivun otsikko
          Text(
            "Muokkaa tietojasi",
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
            label: 'Nykyinen salasana',
            text: user.name, //mustia palloja?
            onChanged: (name) {}, //varmistus (kirjoita uudelleen)
          ),

          const SizedBox(height: 24),

          TextFieldWidget(
            label: 'Uusi salasana',
            text: user.name, //mustia palloja?
            onChanged: (name) {}, //varmistus (kirjoita uudelleen)
          ),

          const SizedBox(height: 14),

          TextFieldWidget(
            label: 'Uudelleen uusi salasana',
            text: user.name, //mustia palloja?
            onChanged: (name) {}, //varmistus (kirjoita uudelleen)
          ),

          const SizedBox(height: 44),

          Center(
            child: ButtonWidget(
              text: 'Tallenna muutokset',
              onClicked: () {
                Navigator.pop(context);
                //tänne tarkistus vanhasta salasanasta/uusista salasanoista
              },
            ),
          ),
        ],
      ),
    );
  }
}
