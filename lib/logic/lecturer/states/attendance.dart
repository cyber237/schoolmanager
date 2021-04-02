import 'package:flutter/material.dart';
import '../db_models/attendance/course.dart';
import '../database/attendance.dart';
import '../services/reqs/attendance.dart';

class AttendanceHistoryState with ChangeNotifier {
  List<Course> _data = [];
  AttendanceConnection attCon = new AttendanceConnection();
  AttendanceLecturerDB db = new AttendanceLecturerDB();
  AttendanceHistoryState() {
    Future.delayed(Duration.zero, () async {
      await load().catchError((e) => null);
    }).catchError((e) => null);
  }

  Future<void> load() async {
    // ignore: return_of_invalid_type_from_catch_error
    List temp = await db.getCourses().catchError((e) => []);
    if (temp.isEmpty) {
      await attCon.getCourses().catchError((e) {
        debugPrint("GET COurse Errror :::");
        return null;
      });
    }
    _data = await db.getCourses().catchError((e) {
      debugPrint("GET COurse Errror :::");
      return null;
    });
    notifyListeners();
  }

  List<Course> get data {
    if (_data.isEmpty) {
      Future.delayed(Duration.zero, () async {
        _data = await db.getCourses().catchError((e) => null);
      }).catchError((e) => null);
    }
    debugPrint("DATA:::$_data");
    return _data;
  }
}
