import 'package:flutter/material.dart';

confirmDelete(BuildContext context, String message, Function onPress) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => onPress(),
              child: const Text('Delete')),
        ],
      );
    },
  );
}
