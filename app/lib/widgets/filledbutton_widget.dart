import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const FilledButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FilledButton(
        style: FilledButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onPressed: onClicked,
        child: Text(text),
      );
}
