import 'package:app/pages/models/event.dart';

class TestData {
  static List<Event> events1 = [
    Event(start: DateTime(2023, 28, 2, 10), end: DateTime(2023, 28, 2, 11)),
    Event(start: DateTime(2023, 28, 2, 11), end: DateTime(2023, 28, 2, 12)),
    Event(start: DateTime(2023, 28, 2, 12), end: DateTime(2023, 28, 2, 13)),
    Event(start: DateTime(2023, 28, 2, 13), end: DateTime(2023, 28, 2, 14)),
    Event(start: DateTime(2023, 28, 2, 14), end: DateTime(2023, 28, 2, 15)),
    Event(start: DateTime(2023, 28, 2, 14), end: DateTime(2023, 28, 2, 15)),
  ];

  static List<Event> events2 = [
    Event(start: DateTime(2023, 28, 2, 15), end: DateTime(2023, 28, 2, 16)),
    Event(start: DateTime(2023, 28, 2, 16), end: DateTime(2023, 28, 2, 17)),
    Event(start: DateTime(2023, 28, 2, 17), end: DateTime(2023, 28, 2, 18)),
    Event(start: DateTime(2023, 28, 2, 18), end: DateTime(2023, 28, 2, 19)),
    Event(start: DateTime(2023, 28, 2, 19), end: DateTime(2023, 28, 2, 20)),
    Event(start: DateTime(2023, 28, 2, 14), end: DateTime(2023, 28, 2, 15)),
  ];
}
