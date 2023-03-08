import 'package:app/pages/models/event.dart';
import 'package:app/testdata/testdata.dart';
import 'package:flutter/material.dart';

class ListViewBuilder extends StatelessWidget {
  static List<Event> events1 = TestData.events1;
  // Tulevaisuudessa testi tähän tai muualle
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            height: 100,
            color: Colors.lightGreen,
            child: Center(
              child: Text(
                "${events1[index].start.hour}-${events1[index].end.hour}",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      },
      itemCount: events1.length,
    );
  }
}
