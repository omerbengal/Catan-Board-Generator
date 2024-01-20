import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with AutomaticKeepAliveClientMixin<DiceScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Text(
        "Dice Screen",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
