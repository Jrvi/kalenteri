import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/textfield_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/localuser.dart';
import 'package:vapaat/utils/user_preferences.dart';
import 'package:vapaat/properties.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  LocalUser user = UserPreferences.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile_edit,
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
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
            label: profile_name,
            text: user.name,
            onChanged: (name) {},
          ),

          const SizedBox(height: 24),

          //Password and modifying it
          TextFieldWidget(
            label: profile_password,
            text: user.name, //not show!
            onChanged: (name) {},
          ),

          const SizedBox(height: 24),

          TextFieldWidget(
            label: profile_new_password,
            text: user.name, //mustia palloja?
            onChanged: (name) {}, //varmistus (kirjoita uudelleen)
          ),

          const SizedBox(height: 14),

          TextFieldWidget(
            label: profile_password_confirm,
            text: user.name,
            onChanged: (name) {}, //does the password match?
          ),

          const SizedBox(height: 44),

          Center(
            child: ButtonWidget(
              text: profile_save,
              onClicked: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
