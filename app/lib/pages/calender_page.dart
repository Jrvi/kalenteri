import 'dart:developer';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/utils/database_util.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController startTimeCtl = TextEditingController();
  TextEditingController endTimeCtl = TextEditingController();

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
              TextButton(
                  onPressed: () {
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
                  child: Text("submit"))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
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
          )
        ],
      ),
    );
  }
}
