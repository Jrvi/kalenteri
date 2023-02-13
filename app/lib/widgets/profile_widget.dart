import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Kuva keskelle sivua
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    //kuva koko määrityksineen
    return Ink.image(
      image: image,
      fit: BoxFit.cover,
      width: 128,
      height: 128,
      //Efekti: Kuvaa painettaessa "aaltomainen" korostus
      child: InkWell(
        onTap: onClicked,
      ),
    );
  }
}
