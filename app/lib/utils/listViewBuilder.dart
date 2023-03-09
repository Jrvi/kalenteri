import 'package:app/pages/models/event.dart';
import 'package:app/testdata/testdata.dart';
import 'package:flutter/material.dart';
import '../widgets/refresh_widget.dart';

class ListViewBuilder extends StatefulWidget {
  @override
  _ListBuildBuilder createState() => _ListBuildBuilder();
}

class _ListBuildBuilder extends State<ListViewBuilder> {
  static List<Event> events = TestData.events1;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final List<Event> events = TestData.events1;

    setState(() => events);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: buildlist())],
    );
  }

  Widget buildlist() => events.isEmpty
      ? Center(child: CircularProgressIndicator())
      : RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          key: keyRefresh,
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return buildItem();
              }),
        );

  Widget buildItem() => ListTile(
        title: Center(child: Text("test")),
      );
}
