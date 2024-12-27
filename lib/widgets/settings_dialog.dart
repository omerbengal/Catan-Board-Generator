import 'package:catan_board_generator/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SettingsDialog extends StatefulWidget {
  final String sessionCode;
  final String uid;
  final bool isAdmin;
  final List<Map<String, dynamic>> usersList;

  const SettingsDialog({
    Key? key,
    required this.sessionCode,
    required this.uid,
    required this.isAdmin,
    required this.usersList,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize name from usersList
    final currentUser = widget.usersList.firstWhere(
      (user) => user['uid'] == widget.uid,
      orElse: () => {'name': ''},
    );
    _nameController.text = currentUser['name'] ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseService().changeUserName(
          widget.sessionCode, widget.uid, _nameController.text.trim());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: Container(
        width: 300,
        height: 400, // Fixed height
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              if (widget.isAdmin)
                Expanded(
                  child: StreamBuilder<DatabaseEvent>(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child('sessions')
                        .child(widget.sessionCode)
                        .child('users')
                        .onValue,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      Map<dynamic, dynamic> usersMap =
                          (snapshot.data?.snapshot.value as Map?) ?? {};

                      List<String> _users = usersMap.values
                          .map((user) => user['name'].toString())
                          .toList();

                      return ReorderableListView(
                        shrinkWrap: true,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item = _users.removeAt(oldIndex);
                            _users.insert(newIndex, item);
                          });
                        },
                        children: [
                          for (var i = 0; i < _users.length; i++)
                            ListTile(
                              key: ValueKey(_users[i]),
                              title: Text(_users[i]),
                            )
                        ],
                      );
                    },
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
          onPressed: _handleSubmit,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
