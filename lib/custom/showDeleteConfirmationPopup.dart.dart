import 'package:blog_todoapp/custom/ConstantColor.dart';
import 'package:flutter/material.dart';

void showDeleteConfirmationPopup(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete task?'),

        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: primarycolor),
            child: const Text('Cancel'),
          ),

          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: primarycolor),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
