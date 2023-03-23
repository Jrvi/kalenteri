import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/widgets/profile_widget.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/localuser.dart';
import 'package:vapaat/pages/edit_profile.dart';
import 'package:vapaat/utils/user_preferences.dart';
import 'package:vapaat/properties.dart';

class Profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
  final LocalUser user = UserPreferences.getUser();
  // Dialogin text controllerit
  TextEditingController dateCtl = TextEditingController();
  TextEditingController startTimeCtl = TextEditingController();
  TextEditingController endTimeCtl = TextEditingController();

  // Tää kyl on laitettava johonkin omaan luokkaa
  Future eventDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Form(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: dateCtl,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter day"),
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    dateCtl.text = date!.toIso8601String();
                  },
                ),
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                  controller: startTimeCtl,
                  decoration: InputDecoration(hintText: "Enter start time"),
                  onTap: () async {
                    TimeOfDay? time = TimeOfDay.now();
                    time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    startTimeCtl.text = time.toString();
                  },
                ),
                TextFormField(
                  controller: endTimeCtl,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter end time"),
                  onTap: () async {
                    TimeOfDay? time = TimeOfDay.now();
                    time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    endTimeCtl.text = time.toString();
                  },
                )
              ]),
            ),
            actions: [
              ButtonWidget(
                  onClicked: () {
                    Navigator.of(context).pop();
                    String startString =
                        "${dateCtl.text.substring(0, 10)} ${startTimeCtl.text.substring(10, 15)}:00";
                    String endString =
                        "${dateCtl.text.substring(0, 10)} ${endTimeCtl.text.substring(10, 15)}:00";
                    Event newEvent = Event(
                        start: DateTime.parse(startString),
                        end: DateTime.parse(endString));
                    DatabaseUtil.addEvent(newEvent);
                  },
                  text: event_add)
            ],
          ));

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
            profile_caption,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 44),
          //Profiilikuva
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: false,
            onClicked: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),

          const SizedBox(height: 24),

          //Nimi ja spo
          buildName(user),

          const SizedBox(height: 64),

          Center(
            //these will go under Calender-page
            child: ButtonWidget(
              text: 'Lisää kalenteri',
              onClicked: () {},
            ),
          ),
          const SizedBox(height: 24),
          Center(
            //these will go under Calender-page
            child: ButtonWidget(
              text: 'Lisää menemisiä',
              onClicked: () {
                eventDialog();
              },
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
