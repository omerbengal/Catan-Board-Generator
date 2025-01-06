import 'package:flutter/material.dart';

class JoinSessionDialog extends StatefulWidget {
  final Function(String code, String name) onJoin;

  const JoinSessionDialog({
    Key? key,
    required this.onJoin,
  }) : super(key: key);

  @override
  _JoinSessionDialogState createState() => _JoinSessionDialogState();
}

class _JoinSessionDialogState extends State<JoinSessionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onJoin(_codeController.text, _nameController.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join Session'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Session Code',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                alignLabelWithHint: false,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a session code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _handleSubmit,
          child: const Text('Join'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
