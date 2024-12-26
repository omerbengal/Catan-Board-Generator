import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DiceSection extends StatefulWidget {
  final String sessionCode;
  // Add onRollDice callback, which is a function that returns a Future<int>
  final Future<List<int>> Function(bool updateFireBase) onRollDice;

  const DiceSection({
    Key? key,
    required this.sessionCode,
    required this.onRollDice,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Share.share(widget.sessionCode);
            },
            child: Text(
              "Session Code:\n${widget.sessionCode}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          //! desable button when dice is rolling
          child: GestureDetector(
            onTap: _isRolling
                ? null
                : () async {
                    setState(() {
                      _isRolling = true;
                    });

                    HapticFeedback.mediumImpact();
                    // widget.onRollDice().then((value) {
                    //   setState(() {
                    //     lastRoll1 = value[0];
                    //     lastRoll2 = value[1];
                    //   });
                    // });
                    for (var i = 1; i <= _numOfFakeRolls; i++) {
                      await Future.delayed(
                        const Duration(milliseconds: 75),
                        () async {
                          List<int> rolls;
                          if (i < _numOfFakeRolls) {
                            rolls = await widget.onRollDice(false);
                          } else {
                            rolls = await widget.onRollDice(true);
                          }
                          setState(
                            () {
                              lastRoll1 = rolls[0];
                              lastRoll2 = rolls[1];
                              if (i == _numOfFakeRolls) {
                                _isRolling = false;
                              }
                            },
                          );
                        },
                      );
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/new/dice' + lastRoll1.toString() + '.png',
                    width: 150),
                const SizedBox(width: 20),
                Image.asset('assets/new/dice' + lastRoll2.toString() + '.png',
                    width: 150),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
