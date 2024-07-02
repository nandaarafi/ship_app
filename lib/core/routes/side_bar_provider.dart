import 'package:flutter/material.dart';

class SideBarProvider with ChangeNotifier {
  bool _isToggled = true;

  bool get isToggled => _isToggled;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners();
  }

  void setToggled(bool value) {
    _isToggled = value;
    notifyListeners();
  }
}