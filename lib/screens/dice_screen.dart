import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:catan_board_generator/widgets/create_session_dialog.dart';
import 'package:catan_board_generator/widgets/join_session_dialog.dart';
import 'package:catan_board_generator/widgets/session_buttons.dart';
import 'package:catan_board_generator/widgets/dice_section.dart';
import 'package:catan_board_generator/widgets/stats_section.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// class DiceScreen extends StatelessWidget {
//   const DiceScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final gameProvider = Provider.of<GameProvider>(context);
//     return Scaffold(
//       body: gameProvider.sessionCode == null
//           ? SessionButtons(
//               onCreateSession: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => CreateSessionDialog(
//                     onCreateSession: (name) async {
//                       await gameProvider.createSession(name);
//                       Navigator.pop(context);
//                     },
//                   ),
//                 );
//               },
//               onJoinSession: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => JoinSessionDialog(
//                     onJoin: (code, name) async {
//                       await gameProvider.joinSession(code, name);
//                       Navigator.pop(context);
//                     },
//                   ),
//                 );
//               },
//             )
//           : DiceSection(),
//     );
//   }
// }

class DiceScreen extends StatelessWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return gameProvider.sessionCode == null
              ? SessionButtons(
                  onCreateSession: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateSessionDialog(
                        onCreateSession: (name) async {
                          await gameProvider.createSession(name);
                          // Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  onJoinSession: () {
                    showDialog(
                      context: context,
                      builder: (context) => JoinSessionDialog(
                        onJoin: (code, name) async {
                          await gameProvider.joinSession(code, name);
                          // Navigator.pop(context);
                        },
                      ),
                    );
                  },
                )
              : PageView(
                  scrollDirection: Axis.vertical,
                  children: [
                    DiceSection(),
                    StatsSection(),
                  ],
                );
        },
      ),
    );
  }
}
