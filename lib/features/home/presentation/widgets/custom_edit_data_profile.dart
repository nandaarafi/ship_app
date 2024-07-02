import 'package:flutter/material.dart';
class CustomEditDataProfile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;

  const CustomEditDataProfile({super.key,
  required this.label,
  required this.value,
  required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }

}