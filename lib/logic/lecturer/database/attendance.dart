import 'package:hive/hive.dart';
import '../db_models/attendance/course.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AttendanceLecturerDB {
  List<Attendance> getAttendance(List attendance) {
    return attendance.isNotEmpty
        ? attendance.map((e) {
            return new Attendance(
                remark: e["remark"],
                time: DateTime.fromMillisecondsSinceEpoch(e["time"]),
                takenBy: e["takenBy"],
                sheet: getStudents(e["data"]));
          }).toList()
        : [];
  }

  List<Student> getStudents(List students) {
    return students != null
        ? students.map((e) {
            return new Student(
                fullName: e["name"],
                id: e["id"],
                remark: e["remark"],
                present: e["status"] == null
                    ? null
                    : e["status"].toString().toLowerCase() == "p"
                        ? true
                        : false);
          }).toList()
        : [];
  }

  Level getLevel(Map level) {
    return new Level(
      id: level["id"],
      name: level["name"],
      students: getStudents(level["students"]),
      speciality: getSpeciality(level["speciality"]),
    );
  }

  Speciality getSpeciality(Map speciality) {
    return new Speciality(
        id: speciality["id"],
        name: speciality["name"],
        department: speciality["department"]);
  }

  Future<void> storeCourses(List courses) async {
    Box courseBox = await Hive.openBox("courses");
    await courseBox.clear();
    if (courses != null || courses.isNotEmpty) {
      await courseBox.addAll(courses.map((e) {
        return new Course(
            name: e["name"],
            id: e["id"],
            level: getLevel(e["level"]),
            hours: e["hours"],
            attendance: getAttendance(e["attendance"]));
      }).toList());
    }
    debugPrint("${courseBox.length}");
    await courseBox.close();
  }

  Future<List<Course>> getCourses() async {
    Box courseBox = await Hive.openBox("courses");
    return courseBox.values.map((e) => e as Course).toList();
  }
}
