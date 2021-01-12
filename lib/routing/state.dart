import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _authChecked = false;
  bool _isLoggedIn = false;

  bool get authChecked => _authChecked;

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    _authChecked = true;
    notifyListeners();
  }
}
