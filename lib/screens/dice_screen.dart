import 'package:catan_board_generator/widgets/join_session_dialog.dart';
import 'package:flutter/material.dart';
import '../widgets/session_buttons.dart';
import '../widgets/dice_section.dart';
import '../widgets/stats_section.dart';
import '../services/firebase_service.dart';
import 'dart:math';

class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  String? sessionCode;
  String? playerName;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: [
          if (sessionCode == null)
            SessionButtons(
              onCreateSession: _handleCreateSession,
              onJoinSession: _handleJoinSession,
            )
          else
            DiceSection(
              sessionCode: sessionCode!,
              onRollDice: _handleDiceRoll,
            ),
          if (sessionCode != null)
            StatsSection(sessionCode: sessionCode!)
          else
            Container(), // Empty container as placeholder when session is null
        ],
      ),
    );
  }

  void _handleCreateSession() async {
    String? newSessionCode = await FirebaseService().createSession();
    setState(() {
      sessionCode = newSessionCode;
    });
  }

  void _handleJoinSession() {
    showDialog(
      context: context,
      builder: (context) => JoinSessionDialog(
        onJoin: (code, name) {
          FirebaseService().checkIfSessionExists(code).then((exists) {
            if (exists) {
              setState(() {
                sessionCode = code;
                playerName = name;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Session does not exist'),
                ),
              );
            }
          });
        },
      ),
    );
  }

  void _handleDiceRoll() async {
    print('Rolling dice, with session code: $sessionCode');
    final random = Random();
    final roll = random.nextInt(6) + random.nextInt(6) + 2;
    print('Rolled: $roll');
    await FirebaseService().updateRoll(sessionCode!, roll);
  }
}
