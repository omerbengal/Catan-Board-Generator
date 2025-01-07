import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:catan_board_generator/widgets/session_buttons.dart';
import 'package:catan_board_generator/widgets/sections/dice_section.dart';
import 'package:catan_board_generator/widgets/sections/stats_section.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DiceScreen extends StatelessWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    return Scaffold(
      body: gameProvider.sessionCode == null
          ? SessionButtons()
          : PageView(
              scrollDirection: Axis.vertical,
              children: [
                DiceSection(),
                StatsSection(),
              ],
            ),
    );
  }
}
