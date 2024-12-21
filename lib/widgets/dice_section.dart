import 'package:flutter/material.dart';

class DiceSection extends StatelessWidget {
  final String sessionCode;
  final VoidCallback onRollDice;

  const DiceSection({
    Key? key,
    required this.sessionCode,
    required this.onRollDice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Session Code: $sessionCode',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onRollDice,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/new/dice.png',
                    width: 100), // Add dice image asset
                const SizedBox(width: 20),
                Image.asset('assets/new/dice.png',
                    width: 100), // Add dice image asset
              ],
            ),
          ),
        ),
      ],
    );
  }
}
