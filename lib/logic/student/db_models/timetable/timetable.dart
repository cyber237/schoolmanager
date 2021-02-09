import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'timetable.g.dart';

@HiveType(typeId: 1)
class TimeTable extends HiveObject {
  @HiveField(0)
  final List<List<Period>> periods;

  @HiveField(1)
  final Map weekInfo;

  @HiveField(2)
  TimeTable prevVersion;

  @HiveField(3)
  double lastModified;

  TimeTable(
      {@required this.periods,
      @required this.weekInfo,
      this.prevVersion,
      this.lastModified});
}

@HiveType(typeId: 12)
class Period {
  @HiveField(0)
  final String courseName;
  @HiveField(1)
  final String courseInfo;
  @HiveField(2)
  final String lecturerName;
  @HiveField(3)
  final String lecturerId;
  @HiveField(4)
  final int start;
  @HiveField(5)
  final int stop;
  @HiveField(6)
  final String state;
  @HiveField(7)
  final String level;
  @HiveField(8)
  final String venue;
  @HiveField(9)
  final Map data;
  const Period(
      {@required this.courseName,
      @required this.courseInfo,
      @required this.lecturerName,
      @required this.lecturerId,
      @required this.start,
      @required this.stop,
      @required this.state,
      @required this.level,
      @required this.venue,
      @required this.data});
}
