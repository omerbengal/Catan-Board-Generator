import 'package:flutter/material.dart';

class SessionButtons extends StatelessWidget {
  final VoidCallback onCreateSession;
  final VoidCallback onJoinSession;

  const SessionButtons({
    Key? key,
    required this.onCreateSession,
    required this.onJoinSession,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onCreateSession,
            child: const Text('Create a session'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onJoinSession,
            child: const Text('Join a session'),
          ),
        ],
      ),
    );
  }
}
