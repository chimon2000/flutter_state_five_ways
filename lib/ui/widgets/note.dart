import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String text;

  const Note({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text('Note: $text'),
    );
  }
}
