import 'package:catan_board_generator/widgets/create_session_dialog.dart';
import 'package:catan_board_generator/widgets/join_session_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/session_buttons.dart';
import '../widgets/dice_section.dart';
import '../widgets/stats_section.dart';
import '../services/firebase_service.dart';
import 'dart:math';
import '../utils/id_generator.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with AutomaticKeepAliveClientMixin<DiceScreen> {
  String? sessionCode;
  String? playerUid;
  int currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: sessionCode == null
          ? SessionButtons(
              onCreateSession: _handleCreateSession,
              onJoinSession: _handleJoinSession,
            )
          : StreamBuilder<DatabaseEvent>(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('sessions')
                  .child(sessionCode ?? '')
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An error occurred. Please try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data?.snapshot.value == null) {
                  return SessionButtons(
                    onCreateSession: _handleCreateSession,
                    onJoinSession: _handleJoinSession,
                  );
                }

                return PageView(
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    DiceSection(
                      sessionCode: sessionCode!,
                      onRollDice: _handleDiceRoll,
                      last_roll1: (snapshot.data?.snapshot.value
                          as Map?)?['last_roll1'],
                      last_roll2: (snapshot.data?.snapshot.value
                          as Map?)?['last_roll2'],
                      userName: (snapshot.data?.snapshot.value
                          as Map?)?['users'][playerUid]['name'],
                      isAdmin: (snapshot.data?.snapshot.value as Map?)?['users']
                          [playerUid]['isAdmin'],
                    ),
                    StatsSection(sessionCode: sessionCode!),
                  ],
                );
              },
            ),
    );
  }

  void _handleCreateSession() async {
    String uid = IdGenerator.generateUniqueId();
    showDialog(
      context: context,
      builder: (context) => CreateSessionDialog(
        onCreateSession: (name) async {
          final code = await FirebaseService().createSession(name, uid);
          setState(() {
            sessionCode = code;
            playerUid = uid;
          });
        },
      ),
    );
  }

  void _handleJoinSession() async {
    String uid = IdGenerator.generateUniqueId();
    showDialog(
      context: context,
      builder: (context) => JoinSessionDialog(
        onJoin: (code, name) async {
          // FirebaseService().checkIfSessionExists(code).then((exists) {
          //   if (exists) {
          //     setState(() {
          //       sessionCode = code;
          //       playerUid = uid;
          //     });
          await FirebaseService().joinSession(code, name, uid).then((joined) {
            if (joined) {
              setState(() {
                sessionCode = code;
                playerUid = uid;
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

  Future<List<int>> _handleDiceRoll(bool updateFireBase) async {
    final random = Random();
    final roll1 = random.nextInt(6) + 1;
    final roll2 = random.nextInt(6) + 1;
    if (updateFireBase) {
      await FirebaseService().updateRoll(sessionCode!, roll1, roll2);
    }
    return [roll1, roll2];
  }
}
