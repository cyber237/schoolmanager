import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'timetable.g.dart';

@HiveType(typeId: 0)
class TimeTable extends HiveObject {
  @HiveField(0)
  final List cells;

  @HiveField(1)
  final Map weekInfo;

  @HiveField(2)
  TimeTable prevVersion;

  TimeTable({@required this.cells, @required this.weekInfo, this.prevVersion});
}
