import 'package:flutter/material.dart';


class QrCodeProvider extends ChangeNotifier {
  bool _isQrCode = false;

  bool get isQrCode => _isQrCode;

  void toggleIsQrCode() {
    _isQrCode = !_isQrCode;
    notifyListeners();
  }

  void setQrCode(bool value) {
    _isQrCode = value;
    notifyListeners();
  }

}