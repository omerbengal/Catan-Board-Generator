import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    gameProvider.oldUserList = List.from(gameProvider.usersList);

    final currentUser = gameProvider.usersList.firstWhere(
      (user) => user['uid'] == gameProvider.playerUid,
      orElse: () => {'name': 'Unknown'},
    );
    final userName = currentUser['name'];
    final isAdmin = currentUser['is_admin'] ?? false;
    final nameController = TextEditingController(text: userName);
    final usersList = gameProvider.usersList;
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: const Text('Settings'),
      content: Container(
        width: 300,
        height: 400,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter your name';
                //   }
                //   return null;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (usersList.any((user) =>
                      user['name'] == value &&
                      user['uid'] != gameProvider.playerUid)) {
                    return 'This name is already taken';
                  }
                  return null;
                },
              ),
              if (isAdmin)
                Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      gameProvider.reorderUsers(oldIndex, newIndex);
                    },
                    children: usersList.map((user) {
                      return ListTile(
                        key: ValueKey(user['uid']),
                        title: Text(
                            '${usersList.indexOf(user) + 1}. ${user['name']}'),
                      );
                    }).toList(),
                  ),
                ),
              if (isAdmin)
                ElevatedButton(
                  onPressed: () async {
                    await gameProvider.shuffleUsers();
                  },
                  child: const Text('Shuffle'),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            gameProvider.usersList = gameProvider.oldUserList;
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (nameController.text != userName) {
                gameProvider.updateUserName(nameController.text);
              }
              await gameProvider.updateUserListBecauseOfTurnChange(usersList);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
