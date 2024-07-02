// import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  const CustomButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: SColors.primaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
