import 'package:flutter/material.dart';
import 'package:ship_apps/core/routes/routes.dart';

class CustomShowDialog {

  static void showCustomDialog(BuildContext context,
  {
    required String title,
    required String message,
    required bool isCancel
  }) { showDialog(
      routeSettings: RouteSettings(),
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
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  )
                : SizedBox.shrink(),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
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
                // AppRouter.router.pop();
                Navigator.of(context).pop(); // Close the dialog
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