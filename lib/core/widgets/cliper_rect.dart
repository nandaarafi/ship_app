import 'package:flutter/material.dart';

import '../helper/helper_functions.dart';

class RoundedClipper extends CustomClipper<Path> {
  final double borderRadius;

  RoundedClipper(this.borderRadius);

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, borderRadius)
      ..lineTo(0, size.height - borderRadius)
      ..quadraticBezierTo(0, size.height, borderRadius, size.height)
      ..lineTo(size.width - borderRadius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - borderRadius)
      ..lineTo(size.width, borderRadius)
      ..quadraticBezierTo(size.width, 0, size.width - borderRadius, 0)
      ..lineTo(borderRadius, 0)
      ..quadraticBezierTo(0, 0, 0, borderRadius)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RoundedClipperWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color primaryColor;
  final Color secondaryColor;

  const RoundedClipperWidget({
    Key? key,
    required this.child,
    required this.borderRadius,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SHelperFunctions.screenHeight(context) * 1,
          color: primaryColor, // Replace with your desired color (SColors.secondaryBackground)
        ),
        ClipPath(
          clipper: RoundedClipper(
              borderRadius
          ),
          child: Container(
            color: secondaryColor, // Replace with your desired color (SColors.primaryBackground)
            height: SHelperFunctions.screenHeight(context) * 1,
            alignment: Alignment.center,
          ),
        ),
        // Positioned(
        //   top: MediaQuery.of(context).size.height * 0.06,
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: childHeader,
        // ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: 0,
          right: 0,
          bottom: 20,
          child: child,
        ),

      ],
    );
  }
}