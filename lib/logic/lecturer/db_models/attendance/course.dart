import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'course.g.dart';

@HiveType(typeId: 2)
class Course extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final Level level;

  @HiveField(3)
  final int hours;

  @HiveField(4)
  final List<Attendance> attendance;

  Course({
    @required this.name,
    @required this.id,
    @required this.level,
    @required this.hours,
    @required this.attendance,
  });
}

@HiveType(typeId: 23)
class Attendance {
  @HiveField(0)
  final DateTime time;
  @HiveField(1)
  final String remark;
  @HiveField(2)
  final String takenBy;
  @HiveField(3)
  final List<Student> sheet;
  const Attendance(
      {@required this.time,
      @required this.remark,
      @required this.takenBy,
      @required this.sheet});
}

@HiveType(typeId: 24)
class Level {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final Speciality speciality;
  @HiveField(3)
  final List<Student> students;
  @HiveField(4)
  List<Attendance> attendance;
  Level(
      {@required this.id,
      @required this.name,
      @required this.students,
      @required this.speciality});
}

@HiveType(typeId: 25)
class Speciality {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String department;

  Speciality(
      {@required this.id, @required this.name, @required this.department});
}

@HiveType(typeId: 26)
class Student {
  Student(
      {@required this.fullName, @required this.id, this.remark, this.present});
  @HiveField(0)
  final String fullName;
  @HiveField(1)
  final String id;
  @HiveField(2)
  String remark;
  @HiveField(3)
  bool present;
}
