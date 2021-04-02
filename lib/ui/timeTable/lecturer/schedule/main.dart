import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:schoolmanager/globalSettings.dart';
import 'package:provider/provider.dart';
import '../../../../logic/lecturer/states/timetable/schedule.dart';
import '../../../../logic/lecturer/db_models/timetable/timetable.dart';

class ScheduleTimeTable extends StatelessWidget {
  ScheduleTimeTable({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      builder: (context) => new TimeTableNotifier(),
      child: new TimeTableDisplay(),
    );
  }
}

class PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _upStream = Provider.of<TimeTableNotifier>(context);
    TimeTable _weekTimeTable = _upStream.data;
    int _dayInfocus = _upStream.dayInfocus;
    String titleLable = generateLabel(
        DateTime.fromMillisecondsSinceEpoch(
            _weekTimeTable.weekInfo['firstDay']),
        _dayInfocus);

    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: new Text(
        titleLable,
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 20, color: MAINHEADTEXTCOLOR.withOpacity(0.9)),
      ),
    );
  }

  String generateLabel(DateTime weekStart, int dayIndex) {
    final DateTime _currentDay = weekStart.add(Duration(days: dayIndex));
    final String label =
        "${Shared().weekDays[_currentDay.weekday - 1].toUpperCase()} ${_currentDay.day} ${Shared().monthList[_currentDay.month - 1].toUpperCase()} ${_currentDay.year}";
    return label;
  }
}
