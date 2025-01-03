import 'package:catan_board_generator/services/firebase_service.dart';
import 'package:catan_board_generator/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DiceSection extends StatefulWidget {
  final String sessionCode;
  final Future<List<int>> Function(bool updateFireBase) onRollDice;
  final int last_roll1;
  final int last_roll2;
  final String uid;
  final int currentTurnNumber;
  final List<Map<String, dynamic>> users_list;

  const DiceSection({
    Key? key,
    required this.sessionCode,
    required this.onRollDice,
    required this.last_roll1,
    required this.last_roll2,
    required this.uid,
    required this.currentTurnNumber,
    required this.users_list,
  }) : super(key: key);

  @override
  State<DiceSection> createState() => _DiceSectionState();
}

class _DiceSectionState extends State<DiceSection> {
  int? lastRoll1 = 1;
  int? lastRoll2 = 1;
  int _numOfFakeRolls = 1;

  @override
  Widget build(BuildContext context) {
    String userName = widget.users_list.firstWhere(
        (element) => element['uid'] == widget.uid,
        orElse: () => {'name': 'Unknown', 'uid': widget.uid})['name'];

    bool isAdmin = widget.users_list.firstWhere(
            (element) => element['uid'] == widget.uid,
            orElse: () => {'is_admin': false})['is_admin'] ??
        false;

    String currentTurnPlayerName = widget.users_list.firstWhere(
        (element) => element['turn_number'] == widget.currentTurnNumber,
        orElse: () => {'name': 'Unknown'})['name'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Welcome, ${userName}!",
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
        Text(
          "Current Turn player name:\n${currentTurnPlayerName}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: !(widget.users_list.firstWhere(
                      (element) => element['uid'] == widget.uid,
                      orElse: () => {'turn_number': -1})['turn_number'] ==
                  widget.currentTurnNumber)
              ? null
              : () async {
                  HapticFeedback.mediumImpact();

                  for (var i = 1; i <= _numOfFakeRolls; i++) {
                    await Future.delayed(
                      const Duration(milliseconds: 75),
                      () async {
                        if (i < _numOfFakeRolls) {
                          await widget.onRollDice(false);
                        } else {
                          await widget.onRollDice(true);
                          await FirebaseService().increaseCurrentTurn(
                              widget.sessionCode, widget.currentTurnNumber);
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
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => SettingsDialog(
                sessionCode: widget.sessionCode,
                uid: widget.uid,
                isAdmin: isAdmin,
              ),
            );
          },
          icon: const Icon(Icons.settings),
          iconSize: 50,
        ),
      ],
    );
  }
}
