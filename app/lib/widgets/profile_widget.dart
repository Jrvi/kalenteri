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
    //Kuva keskelle sivua
    return Center(
      //Stackin avulla useampi widget päällekkäin: muokkaus-painike profiilikuvan päälle
      child: Stack(
        children: [
          buildImage(),
          //Muokkaus-painike profiilikuvan oikeaan alakulmaan
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditButton(Colors.blue),
          ),
        ],
      ),
    );
  }

//Metodi: profiilikuva sivulle
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    //kuvan koko ja ympyrä-muoto määrityksineen
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 180,
          height: 180,
          //Efekti: Kuvaa painettaessa "aaltomainen" korostus
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  //Metodi: muokkaus-painike profiilikuvan päälle
  Widget buildEditButton(Color color) => buildCircle(
        color: Colors.white, //Muokkaus-painikke ympyröity valkoisella
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white, //Muokkaus-painikkeen kuvake valkoisena
            size: 20,
          ),
        ),
      );

  //Kuvan muokaaus-painikkeesta valokoinen ympyrä
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
