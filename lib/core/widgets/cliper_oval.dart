//
//
import 'package:flutter/material.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
//
class OvalClipperStack extends StatelessWidget {
  // final Widget childHeader;
  final Widget child;
  final double topStart;
  final double borderRadius;
  final Color primaryColor;
  final Color secondaryColor;

  const OvalClipperStack({Key? key,
    // required this.childHeader,
    required this.child,
    required this.topStart,
    required this.primaryColor,
    required this.secondaryColor,
    required this.borderRadius,
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
          clipper: BottomOvalClipper(
              height: SHelperFunctions.screenHeight(context) * 0.4,
              ovalRadius: borderRadius
          ),
          child: Container(
            color: secondaryColor, // Replace with your desired color (SColors.primaryBackground)
            height: SHelperFunctions.screenHeight(context) * 1,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          top: topStart,
          left: 0,
          right: 0,
          bottom: 20,
          child: child,
        ),

      ],
    );
  }
}

class RectClipperStack extends StatelessWidget {
  // final Widget childHeader;
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;

  const RectClipperStack({Key? key,
    // required this.childHeader,
    required this.child,
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
          clipper: BottomOvalClipper(
              height: SHelperFunctions.screenHeight(context) * 0.4,
              ovalRadius: 200
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

class BottomOvalClipper extends CustomClipper<Path> {
  final double height;
  final double ovalRadius;

  BottomOvalClipper({
    required this.height,
    required this.ovalRadius
  });

  @override
  Path getClip(Size size) {
    // double height = 300.0;
    // double ovalRadius = 500.0; // Adjust this value as needed

    Path path = Path()
      // ..moveTo(0, ) // bottom-left
      ..moveTo(0, size.height ) // bottom-left
      ..lineTo(0, height) // top-left
      ..arcToPoint(
        Offset(size.width, height),
        radius: Radius.circular(ovalRadius), // Use a fixed radius value
        clockwise: false,
      )
      ..lineTo(size.width, size.height); // bottom-right

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


class RoundedOvalClipper extends CustomClipper<Path> {
  final Size size;

  RoundedOvalClipper(this.size);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 4, size.height / 4, size.width / 2, 0);
    path.quadraticBezierTo(3 * size.width / 4, 0, size.width, size.height / 2);
    path.quadraticBezierTo(3 * size.width / 4, size.height / 4, size.width / 2, size.height);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OvalClipperWidget extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;

  const OvalClipperWidget({
    Key? key,
    required this.child,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedOvalClipper(Size(100, 200)),
      child: Container(
        height: height,
        color: color,
        child: child,
      ),
    );
  }
}
