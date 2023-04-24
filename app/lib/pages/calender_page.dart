import 'dart:developer';
import 'package:table_calendar/table_calendar.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/utils/Calendar_utils.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';
import 'package:flutter/material.dart';

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

  // Handling the back button
  DateTime currentBackPressTime = DateTime.now();
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      final confirm = SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('Press back again to exit'));
      ScaffoldMessenger.of(context).showSnackBar(confirm);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(onWillPop());
      },
      child: Scaffold(
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
            const SizedBox(height: 20),
            Center(
              //these will go under Calender-page
              child: ButtonWidget(
                text: calender_add,
                onClicked: () {
                  eventDialog();
                },
              ),
            ),
            Center(
              child: ButtonWidget(
                text: calender_delete,
                onClicked: () {
                  DatabaseUtil.deleteEvent(_selectedDay?.day.toString(),
                      _selectedDay?.month.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
