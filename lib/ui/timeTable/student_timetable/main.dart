import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:schoolmanager/globalSettings.dart';
import 'package:provider/provider.dart';
import 'studentState.dart';
import 'dashboard.dart';
import '../../../logic/db_models/timetable/timetable.dart';

class StudentTimeTable extends StatelessWidget {
  StudentTimeTable({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            backgroundColor: Colors.white,
            body: new ChangeNotifierProvider(
                builder: (context) => TimeTableNotifier(),
                child: new CustomScrollView(slivers: [
                  SliverAppBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: MAINAPPBARCOLOR.withOpacity(0.9),
                    expandedHeight: 250,
                    title: new PageTitle(),
                    stretch: true,
                    floating: true,
                    pinned: true,
                    forceElevated: true,
                    elevation: 2,
                    flexibleSpace: new FlexibleSpaceBar(
                      background: DashBoard(),
                      collapseMode: CollapseMode.pin,
                      stretchModes: [
                        StretchMode.fadeTitle,
                        StretchMode.zoomBackground,
                      ],
                      // centerTitle: true,
                      // title: new Text("TIME TABLE",
                      //     style: new TextStyle(
                      //         fontSize: 20, color: MAINHEADTEXTCOLOR)),
                    ),
                    actions: [
                      new IconButton(
                        icon: new Icon(Icons.list,
                            size: 30, color: MAINHEADTEXTCOLOR),
                        onPressed: () => null,
                      ),
                    ],
                    leading: new IconButton(
                      icon: new Icon(Icons.chevron_left,
                          size: 30, color: MAINHEADTEXTCOLOR),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                    [
                      TimeTableDisplay(),
                    ],
                  ))
                ]))));
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
