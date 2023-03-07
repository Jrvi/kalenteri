import 'package:app/widgets/profile_widget.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Group extends StatefulWidget {
  @override
  _groupState createState() => _groupState();
}

class _groupState extends State<Group> {
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
            "Ryhman nimi",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
