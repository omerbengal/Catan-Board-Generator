import 'package:flutter/material.dart';

class ExpansionBoardAndBUttons extends StatefulWidget {
  const ExpansionBoardAndBUttons({Key? key}) : super(key: key);

  @override
  State<ExpansionBoardAndBUttons> createState() =>
      _ExpansionBoardAndBUttonsState();
}

class _ExpansionBoardAndBUttonsState extends State<ExpansionBoardAndBUttons> {
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
