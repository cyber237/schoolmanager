import 'package:flutter/material.dart';

class LoginAuth with ChangeNotifier {
  String _id = "";
  String _password = "";
  bool _state = false;

  bool get state => _state;

  set id(String value) {
    _id = value;
    _checkState();
    notifyListeners();
  }

  String get id => _id;

  set password(String value) {
    _password = value;
    _checkState();
    notifyListeners();
  }

  String get password => _password;

  void _checkState() {
    _state = _id.length > 6 &&
        (_id.toLowerCase().startsWith("l") ||
            _id.toLowerCase().startsWith("s")) &&
        _password.length > 8 &&
        _id.isNotEmpty;
  }
}
