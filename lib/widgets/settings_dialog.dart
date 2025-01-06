// import 'dart:async';

// import 'package:catan_board_generator/services/firebase_service.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class SettingsDialog extends StatefulWidget {
//   final String sessionCode;
//   final String uid;
//   final bool isAdmin;

//   const SettingsDialog({
//     Key? key,
//     required this.sessionCode,
//     required this.uid,
//     required this.isAdmin,
//   }) : super(key: key);

//   @override
//   State<SettingsDialog> createState() => _SettingsDialogState();
// }

// class _SettingsDialogState extends State<SettingsDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();

//   StreamSubscription<DatabaseEvent>? _usersSubscription;
//   List<Map<dynamic, dynamic>> _usersList = [];
//   List<Map<dynamic, dynamic>> _oldUsersList = [];

//   @override
//   void initState() {
//     super.initState();
//     _usersSubscription =
//         FirebaseService().getUsersStream(widget.sessionCode).listen((snapshot) {
//       List<Map<dynamic, dynamic>> docs = (snapshot.snapshot.value as Map)
//           .entries
//           .map((entry) => {'uid': entry.key, ...entry.value})
//           .toList();
//       docs.sort((a, b) => a['turn_number'].compareTo(b['turn_number']));

//       setState(() {
//         _usersList = docs;
//         final currentUser = _usersList.firstWhere(
//           (user) => user['uid'] == widget.uid,
//           orElse: () => {'name': '?'},
//         );
//         _nameController.text = currentUser['name'] ?? '?';
//       });
//     });

//     print("In settings dialog, Users list: $_usersList");
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   Future<void> _reorderUsers(int oldIndex, int newIndex) async {
//     _usersSubscription?.pause();
//     final list = [..._usersList];
//     if (oldIndex < newIndex) newIndex -= 1;
//     final item = list.removeAt(oldIndex);
//     list.insert(newIndex, item);
//     setState(() {
//       _usersList = list; // show new order locally
//       _oldUsersList = list; // keep old order for cancel
//     });
//   }

//   void _handleSubmit() async {
//     if (_formKey.currentState!.validate()) {
//       await FirebaseService().changeUserName(
//           widget.sessionCode, widget.uid, _nameController.text.trim());
//       Navigator.of(context).pop();
//     }
//     await FirebaseService().updateTurnOrder(widget.sessionCode, _usersList);
//     _usersSubscription?.resume();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Settings'),
//       content: Container(
//         width: 300,
//         height: 400, // Fixed height
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                   alignLabelWithHint: false,
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               if (widget.isAdmin)
//                 Expanded(
//                   child: ReorderableListView(
//                     shrinkWrap: true,
//                     onReorder: _reorderUsers,
//                     children: [
//                       for (final user in _usersList)
//                         ListTile(
//                           key: ValueKey(user['uid']),
//                           title: Text(user['name']),
//                         )
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Reset users list to the old order
//             setState(() {
//               _usersList = _oldUsersList;
//             });
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//         TextButton(
//           onPressed: _handleSubmit,
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:catan_board_generator/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final sessionCode = gameProvider.sessionCode;
    final currentUser = gameProvider.usersList.firstWhere(
      (user) => user['uid'] == gameProvider.playerUid,
      orElse: () => {'name': 'Unknown'},
    );
    final userName = currentUser['name'];
    final isAdmin = currentUser['is_admin'] ?? false;
    final nameController = TextEditingController(text: userName);
    final usersList = gameProvider.usersList;

    return AlertDialog(
      title: const Text('Settings'),
      content: Container(
        width: 300,
        height: 400,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
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
                        title: Text(user['name']),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            if (nameController.text != userName) {
              gameProvider.updateUserName(nameController.text);
            }
            await FirebaseService().updateTurnOrder(sessionCode!, usersList);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
