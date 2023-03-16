import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //With stack, edit-icon in front of image
      children: [
        Stack(
          children: [
            buildImage(),
            //Edit button in the right corner of the image
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditButton(Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

//Prifilepicture on the page
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    //Images size and circle form
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          //Efect when image is clicked
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  //Edit button in front of profile picture
  Widget buildEditButton(Color color) => buildCircle(
        color: Colors.white, //Edit-button circled with white line
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white, //Muokkaus-painikkeen kuvake valkoisena
            size: 15,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
