import 'package:vapaat/pages/models/event.dart';

class TestData {
  static List<Event> events1 = [
    Event(
      start: DateTime(2023, 3, 10, 9, 0),
      end: DateTime(2023, 3, 10, 10, 0),
    ),
    Event(
      start: DateTime(2023, 3, 10, 11, 0),
      end: DateTime(2023, 3, 10, 12, 0),
    ),
    Event(
      start: DateTime(2023, 3, 10, 14, 0),
      end: DateTime(2023, 3, 10, 15, 30),
    ),
  ];

  static List<Event> events2 = [
    Event(
      start: DateTime(2023, 3, 10, 9, 0),
      end: DateTime(2023, 3, 10, 10, 0),
    ),
    Event(
      start: DateTime(2023, 3, 10, 11, 0),
      end: DateTime(2023, 3, 10, 12, 0),
    ),
    Event(
      start: DateTime(2023, 3, 10, 16, 0),
      end: DateTime(2023, 3, 10, 17, 30),
    ),
    Event(
        start: DateTime(2023, 3, 10, 19, 0), end: DateTime(2023, 3, 10, 20, 0)),
  ];
}
