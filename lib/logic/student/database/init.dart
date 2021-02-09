import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db_models/timetable/timetable.dart';

Future<void> registerStudentAdapters() async {
  await Hive.initFlutter();
  _timeTableAdapters();
}

void _timeTableAdapters() {
  Hive.registerAdapter(TimeTableAdapter());
  Hive.registerAdapter(PeriodAdapter());
}
