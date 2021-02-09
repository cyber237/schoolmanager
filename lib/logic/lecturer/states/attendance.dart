import 'package:flutter/material.dart';
import '../db_models/attendance/course.dart';
import '../database/attendance.dart';

class AttendanceHistoryState with ChangeNotifier {
  List<Course> _data = [];
  CourseLecturerDB db = new CourseLecturerDB();
  AttendanceHistoryState() {
    load();
  }

  void load() async {
    _data = await db.getCourses();
    notifyListeners();
  }

  List<Course> get data {
    _data.isEmpty ?? load();
    debugPrint("DATA:::$_data");
    return _data;
  }
}
