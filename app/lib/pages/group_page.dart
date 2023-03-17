import 'package:vapaat/pages/models/group.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';

class GroupPage extends StatefulWidget {
  final Group group;
  GroupPage({required this.group});

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late TextEditingController _nameController;
  late ScrollController _scrollController;
  late ScrollController _listViewController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.group.name);
    _scrollController = ScrollController();
    _listViewController = ScrollController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    _listViewController.dispose();
    super.dispose();
  }

  void _updateGroupName(String name) {
    setState(() {
      widget.group.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.group.name,
          textAlign:
              TextAlign.center, //does not align in the center yet, fix later
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 34),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: group_edit_name,
            ),
            onChanged: _updateGroupName,
          ),
          const SizedBox(height: 54),
          Text(
            group_members,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 320,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _listViewController,
                itemCount: widget.group.members.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //kuva puuttuu
                    title: Text(widget.group.members[index]),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 54),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ButtonWidget(text: group_add_member, onClicked: () {}),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: Text(group_exit),
              ),
            ],
          )
        ],
      ),
    );
  }
}
