import 'package:hive/hive.dart';
import 'package:schoolmanager/logic/shared/db_models/user/type.dart';
import '../db_models/user/user.dart';

void registerSharedAdapters() {
  _userAdapters();
}

void _userAdapters() {
  Hive.registerAdapter(UserTypeAdapter());
  Hive.registerAdapter(UserAdapter());
}
