import 'package:catan_board_generator/barGraph/barGraph.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  List<int> numberCounter = [
    4,
    10,
    3,
    8,
    4,
    7,
    16,
    12,
    2,
    1,
    9,
    0,
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Dice(),
          SizedBox(
            height: 30,
          ),
          MyBarGraph(
            numberCounter: numberCounter,
          ),
        ],
      ),
    );
  }
}

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int firstDiceNumber = 1;
  int secondDiceNumber = 1;

  void update() {
    setState(() {
      firstDiceNumber = Random().nextInt(6) + 1;
      secondDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        for (int i = 0; i < 7; i++) {
          await Future.delayed(Duration(milliseconds: 100), () {
            update();
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/new/dices/red$firstDiceNumber.png',
            width: 150,
          ),
          Image.asset(
            'assets/new/dices/yellow$secondDiceNumber.png',
            width: 150,
          ),
        ],
      ),
    );
  }
}
