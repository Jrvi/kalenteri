import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(), padding: EdgeInsets.all(60)),
        //todo: Tekstin koko järkeväksi, kahdelle riville
        child: Text(text),
        onPressed: onClicked,
      );
}
