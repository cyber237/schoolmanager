import 'package:flutter/material.dart';
import '../services/authentication/auth.dart';
import '../services/authentication/status.dart';

class AuthState extends Auth with ChangeNotifier {
  Status _currentStatus;

  Status get currentStatus => _currentStatus;
  Future<Status> loginWithDetails(String id) async {
    await login(id).whenComplete(() => _currentStatus = status);
    return _currentStatus;
  }
}
