import 'dart:developer';
import 'package:table_calendar/table_calendar.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/utils/Calendar_utils.dart';
import 'package:vapaat/utils/database_util.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  TextEditingController startTimeCtl = TextEditingController();
  TextEditingController endTimeCtl = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future eventDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Form(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                        "${_focusedDay.toString().substring(0, 10)} ${startTimeCtl.text.substring(10, 15)}:00";
                    String endString =
                        "${_focusedDay.toString().substring(0, 10)} ${endTimeCtl.text.substring(10, 15)}:00";
                    Event newEvent = Event(
                        start: DateTime.parse(startString),
                        end: DateTime.parse(endString));
                    DatabaseUtil.addEvent(newEvent);
                    log(_focusedDay.toString());
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
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
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
