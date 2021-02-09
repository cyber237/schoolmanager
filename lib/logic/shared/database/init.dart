import 'package:hive/hive.dart';
import 'dart:async';
import '../db_models/user/user.dart';
import '../db_models/user/type.dart';

Future<void> registerSharedAdapters() async {
  _userDataAdapters();
}

void _userDataAdapters() async {
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserTypeAdapter());
}
