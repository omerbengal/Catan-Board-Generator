import 'package:catan_board_generator/widgets/join_session_dialog.dart';
import 'package:flutter/material.dart';
import '../widgets/session_buttons.dart';
import '../widgets/dice_section.dart';
import '../widgets/stats_section.dart';

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
    // TODO: Implement Firebase connection to generate unique code
    setState(() {
      sessionCode = 'GENERATED_CODE'; // Replace with actual generated code
    });
  }

  void _handleJoinSession() {
    showDialog(
      context: context,
      builder: (context) => JoinSessionDialog(
        onJoin: (code, name) {
          setState(() {
            sessionCode = code;
            playerName = name;
          });
        },
      ),
    );
  }

  void _handleDiceRoll() {
    // TODO: Implement dice roll logic and Firebase update
    print('Dice rolled!');
  }
}
