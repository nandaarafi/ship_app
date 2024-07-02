import 'package:flutter/material.dart';

class CustomShowDialog {

  static void showCustomDialog(BuildContext context,
  {
    required String title,
    required String message,
    required bool isCancel
  }) { showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            //Is Cancel Button
            isCancel
                ? TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Cancel'),
                  )
                : SizedBox.shrink(),

            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showOnPressedDialog(BuildContext context,
  {
    required String title,
    required String message,
    required bool isCancel,
    required VoidCallback onPressed
  }) { showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            //Is Cancel Button
            isCancel
                ? TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            )
                : SizedBox.shrink(),

            TextButton(
              onPressed: onPressed,
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}