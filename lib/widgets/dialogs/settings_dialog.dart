import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    if (gameProvider
            .settingsDialogCounterForSavingOldUserListOnlyTheFirstTime ==
        0) {
      gameProvider.oldUserList = List.from(gameProvider.usersList);
      gameProvider.settingsDialogCounterForSavingOldUserListOnlyTheFirstTime =
          1;
    }

    final currentUser = gameProvider.usersList.firstWhere(
      (user) => user['uid'] == gameProvider.playerUid,
      orElse: () => {'name': 'Unknown'},
    );
    final userName = currentUser['name'];
    final isAdmin = currentUser['is_admin'] ?? false;
    final nameController = TextEditingController(text: userName);
    final usersList = gameProvider.usersList;
    final formKey = GlobalKey<FormState>();

    if (gameProvider.isLoading) {
      return AlertDialog(
        title: const Text('Settings'),
        content: Container(
          width: 300,
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

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
                  onPressed: () {
                    gameProvider.shuffleUsers();
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
            if (gameProvider.oldUserList.isNotEmpty) {
              gameProvider.usersList = gameProvider.oldUserList;
            }

            // We exit the dialog, so we need to reset the counter to 0
            // we do this so the next time we open the dialog, we can save the
            // (Future) current user list
            gameProvider
                .settingsDialogCounterForSavingOldUserListOnlyTheFirstTime = 0;

            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              bool changedName = nameController.text != userName;
              bool changedList =
                  gameProvider.usersList != gameProvider.oldUserList;
              if (changedName || changedList) {
                gameProvider.isLoading = true;
                if (changedName) {
                  await gameProvider.updateUserName(nameController.text);
                }
                if (changedList) {
                  await gameProvider.updateUserListBecauseOfTurnChange(
                      gameProvider.usersList);
                }
                gameProvider.isLoading = false;

                // We exit the dialog, so we need to reset the counter to 0
                // we do this so the next time we open the dialog, we can save the
                // (Future) current user list
                gameProvider
                    .settingsDialogCounterForSavingOldUserListOnlyTheFirstTime = 0;
              }

              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
