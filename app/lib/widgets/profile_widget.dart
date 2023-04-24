import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //With stack, edit-icon in front of image
      children: [
        Stack(
          children: [
            buildImage(),
          ],
        ),
      ],
    );
  }

//Prifilepicture on the page
  Widget buildImage() {
    final image = AssetImage('assets/user.png');

    //Images size and circle form
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  //Edit button in front of profile picture.
  //someday to be added
/*  Widget buildEditButton(Color color) => buildCircle(
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
      );*/

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
