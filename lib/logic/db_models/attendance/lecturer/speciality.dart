import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'speciality.g.dart';

@HiveType(typeId: 2)
class Speciality extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String department;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final List<Level> levels;

  Speciality(
      {@required this.name,
      @required this.department,
      @required this.id,
      @required this.levels});
}

class Attendance {
  final DateTime time;
  final String generalRemark;
  final String takenBy;
  final List<Student> studentSheet;
  const Attendance(
      {@required this.time,
      @required this.generalRemark,
      @required this.takenBy,
      @required this.studentSheet});
}

class Level {
  final String name;
  final String id;
  final List<Student> students;
  List<Attendance> attendance;
  Level({this.id, this.name, this.students});
}

class Student {
  Student({this.fullName, this.id});
  final String fullName;
  final String id;
  String remark;
  bool present;
}
