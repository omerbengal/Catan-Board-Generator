import 'package:catan_board_generator/widgets/dialogs/create_session_dialog.dart';
import 'package:catan_board_generator/widgets/dialogs/join_session_dialog.dart';
import 'package:flutter/material.dart';
import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:provider/provider.dart';

class SessionButtons extends StatelessWidget {
  const SessionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
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
            child: const Text('Create a session'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
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
            child: const Text('Join a session'),
          ),
        ],
      ),
    );
  }
}
