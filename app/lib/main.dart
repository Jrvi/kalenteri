import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView (
        physics: BouncingScrollPhysics(),
        children: [],
      ),
      ),
  }
}