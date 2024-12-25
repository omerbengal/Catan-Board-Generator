import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Session Code: ${widget.sessionCode}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              // widget.onRollDice().then((value) {
              //   setState(() {
              //     lastRoll1 = value[0];
              //     lastRoll2 = value[1];
              //   });
              // });
              for (var i = 1; i <= 10; i++) {
                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () async {
                    List<int> rolls;
                    if (i < 10) {
                      rolls = await widget.onRollDice(false);
                    } else {
                      rolls = await widget.onRollDice(true);
                    }
                    setState(
                      () {
                        lastRoll1 = rolls[0];
                        lastRoll2 = rolls[1];
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
