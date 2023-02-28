import 'package:app/widgets/textfield_widget.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/models/user.dart';
import 'dart:io';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),

          //Sivun otsikko
          Text(
            "Luo ryhmä",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 44),

          SizedBox(
            width: 300,
            child: TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Ryhmän nimi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          SizedBox(height: 34),

          Text(
            "Lisää jäseniä",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Kirjoita kaverin nimi',
              suffixIcon: Icon(Icons.search),
            ),
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: skip painikkeelle toiminnot; hylkää jos ryhmälle on jo nimi ja jäsenet?
                },
                child: Text('Peruuta'),
              ),
              SizedBox(width: 64),
              ElevatedButton(
                onPressed: () {
                  // TODO: Luo ryhmä ja tallennsa se
                  String groupName = _groupNameController.text;
                  print('Luodaan ryhmä: $groupName');
                },
                child: Text('Luo ryhmä'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
