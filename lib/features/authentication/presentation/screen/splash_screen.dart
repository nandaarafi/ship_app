import 'package:flutter/material.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/constants.dart';
import 'package:ship_apps/core/routes/routes.dart';
import 'package:ship_apps/core/widgets/cliper_wave.dart';

import '../../../../core/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      AppRouter.router.go(Routes.signInNamedPage);
    });
    return Scaffold(
        body: WaveClipperReverseStack(
          topStart: SHelperFunctions.screenHeight(context) * 0.1,
          height: SHelperFunctions.screenHeight(context) * 0.6,
          primaryColor: SColors.primaryBackground,
          secondaryColor: SColors.secondaryBackground,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/vector_asset/logos_ship_app.png",
                  width: SHelperFunctions.screenWidth(context) * 0.4,
                ),
                SizedBox(height: 14.0),
                Text(
                  'SMART GUARD BOX',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: SHelperFunctions.screenHeight(context) * 0.25),
                Text(
                  "MARI AMANKAN PAKETMU!!!",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: SColors.secondaryBackground,
        ),
        ClipPath(
          clipper: WaveClipperReverse(), // Custom clipper defined below
          child: Container(
            color: SColors.primaryBackground,
            height: SHelperFunctions.screenHeight(context) * 0.6,
          ),
        ),
         Positioned(
           top: SHelperFunctions.screenHeight(context) * 0.1,
           left: 0,
           right: 0,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/vector_asset/logos_ship_app.png",
                    width: SHelperFunctions.screenWidth(context) * 0.4,
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    'SMART GUARD BOX',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.25),
                  Text(
                      "MARI AMANKAN PAKETMU!!!",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      color: Colors.black
                    ),
                  )
                ],
              ),
           ),
         ),
      ],
    );
  }
}

// class WaveClipperReverse extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//
//     // Start from top-left corner
//     path.lineTo(0, size.height * 0.8);
//
//     // Define two control points for the bezier curve on the left
//     var controlPoint1 = Offset(size.width * 0.20, size.height * 0.6);
//     var endPoint1 = Offset(size.width * 0.7, size.height * 0.9);
//     path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);
//
//     // Define two control points for the bezier curve on the right
//     var controlPoint2 = Offset(size.width * 0.9, size.height * 1);
//     var endPoint2 = Offset(size.width, size.height * 0.9);
//     path.quadraticBezierTo(controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);
//
//     // Line to bottom-right corner
//     path.lineTo(size.width, 0);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

