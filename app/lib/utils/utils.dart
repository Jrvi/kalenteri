import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Tapahtuma luokka
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Esimerkki lista tapahtumista
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Tapahtuma $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Testi tapahtuma 1'),
      Event('Testi tapahtuma 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Palauttaa listan tapahtumista
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
