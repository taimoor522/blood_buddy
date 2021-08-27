import 'package:flutter/material.dart';

import '../constants.dart';

class MyCard extends StatefulWidget {
  final String text;

  MyCard({required this.text});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },
      child: Card(
        color: _selected ? myRed : Colors.white,
        elevation: 5,
        child: SizedBox(
          width: 70,
          height: 70,
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 30,
                color: _selected ? Colors.white : myRed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
