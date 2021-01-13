import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db_models/timetable/timetable.dart';

void registerAllAdapters() async {
  await Hive.initFlutter();
  registerTimeTableAdapters();
}

void registerTimeTableAdapters() {
  Hive.registerAdapter(TimeTableAdapter());
  Hive.registerAdapter(PeriodAdapter());
}
