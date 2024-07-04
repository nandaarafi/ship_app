import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../errors/routes_error.dart';

class Routes {
  static const splashScreenNamedPageRoot = '/splash-screen';
  static const signInNamedPage = '/sign-in';
  static const signUpNamedPage = '/sign-up';
  static const forgotPassNamedPage = '/forgot-pass';

  static const profileNamedPage = '/profile';
  static const editProfileNamedPage = '/edit-profile';
  static const qrCodeNamedPage = '/qr-code';

  static const packetCapacityNamedPage = '/packet-capacity';
  static const historyNamedPage = '/history';
  static const logoutNamedPage = '/logout';
  static const daftarResiNamedPage = '/daftar-resi';
  static const checkResiNamedPage = '/cek-resi';
  static const loadingNamedPage = '/loading';


  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}