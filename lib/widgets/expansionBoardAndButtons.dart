import 'package:flutter/material.dart';

class ExpansionBoardAndButtons extends StatefulWidget {
  const ExpansionBoardAndButtons({Key? key}) : super(key: key);

  @override
  State<ExpansionBoardAndButtons> createState() =>
      _ExpansionBoardAndButtonsState();
}

class _ExpansionBoardAndButtonsState extends State<ExpansionBoardAndButtons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Expansion Board",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
