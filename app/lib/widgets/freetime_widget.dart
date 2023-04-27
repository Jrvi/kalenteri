import 'package:vapaat/pages/models/TimeSlot.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/utils/database_utils.dart';

class Freetime extends StatefulWidget {
  @override
  State<Freetime> createState() => _FreetimeState();
}

class _FreetimeState extends State<Freetime> {
  List<TimeSlot> freeTimeSlots = [];

  void getFreeTimeSlotsForTwoCalendars(DateTime startDate, DateTime endDate,
      {int duration = 60}) {
    // Retrieve events from both calendars between start and end dates
    final person1Events = DatabaseUtil.getOwnEvents();
    final person2Events = DatabaseUtil.getFriendsEvents();

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
  }

  Future refresh() async {
    freeTimeSlots.clear();
    setState(() {
      getFreeTimeSlotsForTwoCalendars(
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0),
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1, 0, 0),
          duration: 30);
    });
  }

  @override
  void initState() {
    super.initState();
    DatabaseUtil.clearEvents();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Vapaatajat"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: freeTimeSlots.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 125,
              child: Card(
                child: ListTile(
                  title: Text(
                      "${freeTimeSlots[index].start.hour.toString()}.${freeTimeSlots[index].start.minute.toString()}-${freeTimeSlots[index].end.hour.toString()}.${freeTimeSlots[index].end.minute.toString()}"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
