import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'timetable.g.dart';

@HiveType(typeId: 100)
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

@HiveType(typeId: 120)
class Period {
  @HiveField(0)
  final String courseName;
  @HiveField(1)
  final String courseInfo;
  @HiveField(2)
  final List group;
  @HiveField(3)
  final int start;
  @HiveField(4)
  final int stop;
  @HiveField(5)
  final String state;
  @HiveField(6)
  final String venue;
  @HiveField(7)
  final Map data;
  const Period(
      {@required this.courseName,
      @required this.courseInfo,
      @required this.start,
      @required this.stop,
      @required this.state,
      @required this.group,
      @required this.venue,
      @required this.data});
}
