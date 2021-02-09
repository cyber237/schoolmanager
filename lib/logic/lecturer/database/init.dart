import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db_models/attendance/course.dart';

Future<void> registerLecturerAdapters() async {
  await Hive.initFlutter();
  _attendanceAdapters();
}

void _attendanceAdapters() {
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(SpecialityAdapter());
  Hive.registerAdapter(LevelAdapter());
  Hive.registerAdapter(AttendanceAdapter());
  Hive.registerAdapter(StudentAdapter());
}
