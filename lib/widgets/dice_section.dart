import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DiceSection extends StatefulWidget {
  final String sessionCode;
  // Add onRollDice callback, which is a function that returns a Future<int>
  final Future<List<int>> Function(bool updateFireBase) onRollDice;
  final int last_roll1;
  final int last_roll2;
  final String userName;
  final bool isAdmin;

  const DiceSection({
    Key? key,
    required this.sessionCode,
    required this.onRollDice,
    required this.last_roll1,
    required this.last_roll2,
    required this.userName,
    required this.isAdmin,
  }) : super(key: key);

  @override
  State<DiceSection> createState() => _DiceSectionState();
}

class _DiceSectionState extends State<DiceSection> {
  int? lastRoll1 = 1;
  int? lastRoll2 = 1;
  bool _isRolling = false;
  int _numOfFakeRolls = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Welcome, ${widget.userName}!",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () {
            Share.share(widget.sessionCode);
          },
          child: Text(
            "Session Code:\n${widget.sessionCode}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap:
              _isRolling // If the dice are rolling, do not allow another roll
                  ? null
                  : () async {
                      setState(() {
                        _isRolling = true;
                      });

                      HapticFeedback.mediumImpact();
                      for (var i = 1; i <= _numOfFakeRolls; i++) {
                        await Future.delayed(
                          const Duration(milliseconds: 75),
                          () async {
                            if (i < _numOfFakeRolls) {
                              await widget.onRollDice(false);
                            } else {
                              await widget.onRollDice(true);
                            }
                            if (i == _numOfFakeRolls) {
                              setState(() {
                                _isRolling = false;
                              });
                            }
                          },
                        );
                      }
                    },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/new/dice' + widget.last_roll1.toString() + '.png',
                  width: 150),
              const SizedBox(width: 20),
              Image.asset(
                  'assets/new/dice' + widget.last_roll2.toString() + '.png',
                  width: 150),
            ],
          ),
        ),
        if (widget.isAdmin)
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Admin!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            iconSize: 50,
          )
      ],
    );
  }
}
