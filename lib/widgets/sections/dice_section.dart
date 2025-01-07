import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:catan_board_generator/widgets/dialogs/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DiceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final sessionCode = gameProvider.sessionCode;
    final usersList = gameProvider.usersList;
    final currentUser = usersList.firstWhere(
      (user) => user['uid'] == gameProvider.playerUid,
      orElse: () => {'name': 'Unknown', 'uid': ''},
    );
    final currentTurnUser = usersList.firstWhere(
      (user) => user['turn_number'] == gameProvider.currentTurnNumber,
      orElse: () => {'name': 'Unknown'},
    );

    return (gameProvider.lastRoll1 == 0 ||
            gameProvider.lastRoll2 == 0 ||
            sessionCode == null ||
            usersList.isEmpty ||
            gameProvider.currentTurnNumber == 0)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Welcome, ${currentUser['name']}!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  Share.share(gameProvider.sessionCode!);
                },
                child: Text(
                  "Session Code:\n${gameProvider.sessionCode}",
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
                "Current Turn player name:\n${currentTurnUser['name']}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap:
                    currentUser['turn_number'] == gameProvider.currentTurnNumber
                        ? () async {
                            await gameProvider.rollDice();
                          }
                        : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/new/dice${gameProvider.lastRoll1}.png',
                      width: 150,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      'assets/new/dice${gameProvider.lastRoll2}.png',
                      width: 150,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SettingsDialog(),
                  );
                },
                icon: const Icon(Icons.settings),
                iconSize: 50,
              ),
            ],
          );
  }
}
