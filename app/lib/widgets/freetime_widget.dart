import 'dart:developer';
import 'package:vapaat/pages/models/TimeSlot.dart';
import 'package:vapaat/testdata/testdata.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/properties.dart';

class Freetime extends StatefulWidget {
  @override
  State<Freetime> createState() => _FreetimeState();
}

class _FreetimeState extends State<Freetime> {
  List<TimeSlot> freeTimeSlots = [];

  void getFreeTimeSlotsForTwoCalendars(DateTime startDate, DateTime endDate,
      {int duration = 60}) {
    // Retrieve events from both calendars between start and end dates
    final person1Events = TestData.events1;
    final person2Events = TestData.events2;

    // Merge the two calendars' events
    final allEvents = [...person1Events, ...person2Events];
    // Sort events by start time
    allEvents.sort((a, b) => a.start.compareTo(b.start));

    // Convert events to time slots
    final timeSlots =
        allEvents.map((event) => TimeSlot(event.start, event.end)).toList();

    // Add free time slots
    if (timeSlots.isEmpty) {
      freeTimeSlots.add(TimeSlot(startDate, endDate));
    } else {
      if (timeSlots.first.start.isAfter(startDate)) {
        freeTimeSlots.add(TimeSlot(startDate, timeSlots.first.start));
      }
      for (int i = 0; i < timeSlots.length - 1; i++) {
        final eventEnd = timeSlots[i].end;
        final nextEventStart = timeSlots[i + 1].start;

        if (eventEnd.isBefore(nextEventStart)) {
          final freeTimeSlot = TimeSlot(
              eventEnd, nextEventStart.subtract(Duration(minutes: duration)));
          freeTimeSlots.add(freeTimeSlot);
        }
      }
      if (timeSlots.last.end.isBefore(endDate)) {
        freeTimeSlots.add(TimeSlot(timeSlots.last.end, endDate));
      }
    }

    log("data. $timeSlots");
    log("free: $freeTimeSlots");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "Vapaatajat",
                style: TextStyle(color: Colors.black),
              ),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text("Have a nice day"),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: index.isOdd ? Colors.green : Colors.lightGreen,
                    height: 100.0,
                    child: Center(
                        child: Text(
                            "${freeTimeSlots[index].start.hour.toString()}.${freeTimeSlots[index].start.minute.toString()}-${freeTimeSlots[index].end.hour.toString()}.${freeTimeSlots[index].end.minute.toString()}")),
                  ),
                );
              },
              childCount: freeTimeSlots.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                DatabaseUtil.getLocalUser();
                setState(() {
                  getFreeTimeSlotsForTwoCalendars(
                      DateTime(2023, 3, 10, 0, 0), DateTime(2023, 3, 11, 0, 0),
                      duration: 30);
                });
              },
              child: Text(freetime_update),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    freeTimeSlots.clear();
                  });
                },
                child: Text(freetime_clear))
          ],
        ),
      )),
    );
  }
}
