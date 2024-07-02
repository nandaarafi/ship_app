

import 'package:flutter/material.dart';

import '../helper/helper_functions.dart';

class WaveClipperReverseStack extends StatelessWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final double height;
  final double topStart;

  const WaveClipperReverseStack({Key? key,
    required this.child,
    required this.primaryColor,
    required this.secondaryColor,
    required this.height,
    required this.topStart,
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
          clipper: WaveClipperReverse(),
          child: Container(
            color: secondaryColor, // Replace with your desired color (SColors.primaryBackground)
            height: height,
          ),
        ),
        Positioned(
          top: topStart,
          left: 0,
          right: 0,
          child: child,
        ),
      ],
    );
  }
}

class WaveClipperStack extends StatelessWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final double height;

  const WaveClipperStack({Key? key,
    required this.child,
    required this.primaryColor,
    required this.secondaryColor,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: primaryColor, // Replace with your desired color (SColors.secondaryBackground)
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: secondaryColor, // Replace with your desired color (SColors.primaryBackground)
            height: height,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.01,
          left: 0,
          right: 0,
          child: child,
        ),
      ],
    );
  }
}

class WaveClipperReverse extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from top-left corner
    path.lineTo(0, size.height * 0.8);

    // Define two control points for the bezier curve on the left
    var controlPoint1 = Offset(size.width * 0.20, size.height * 0.6);
    var endPoint1 = Offset(size.width * 0.7, size.height * 0.9);
    path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    // Define two control points for the bezier curve on the right
    var controlPoint2 = Offset(size.width * 0.9, size.height * 1);
    var endPoint2 = Offset(size.width, size.height * 0.9);
    path.quadraticBezierTo(controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    // Line to bottom-right corner
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from top-left corner
    path.lineTo(0, size.height * 0.9);

    // Define two control points for the bezier curve on the left
    var controlPoint1 = Offset(size.width * 0.20, size.height * 0.8);
    var endPoint1 = Offset(size.width * 0.50, size.height * 0.85);
    path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    // Define two control points for the bezier curve on the right

    var controlPoint2 = Offset(size.width * 0.75, size.height * 0.9);
    var endPoint2 = Offset(size.width, size.height * 0.67);
    path.quadraticBezierTo(controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    // var controlPoint3 = Offset(size.width * 1.2, size.height * 0.5);
    // var endPoint3 = Offset(size.width, size.height * 1);
    // path.quadraticBezierTo(controlPoint3.dx, controlPoint3.dy, endPoint3.dx, endPoint3.dy);
    // Line to bottom-right corner
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

