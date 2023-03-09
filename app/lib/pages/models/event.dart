class Event {
  final DateTime start;
  final DateTime end;

  const Event({
    required this.start,
    required this.end,
  });

  static List<Event> calendarsOverlap(
      List<Event> calendar1, List<Event> calendar2) {
    List<Event> events = [];
    calendar1.sort((a, b) => a.start.compareTo(b.start));
    calendar2.sort((a, b) => a.start.compareTo(b.start));

    for (var i = 0; i < calendar1.length; i++) {
      if (!(Event.isEventOverlapping(calendar1[i], calendar2[i]))) {
        events.add(calendar1[i]);
      }
    }
    return events;
  }

  static bool isEventOverlapping(Event a, Event b) {
    return a.start.isBefore(b.end) && a.end.isAfter(b.end);
  }
}
