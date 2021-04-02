import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:schoolmanager/globalSettings.dart';
import 'schedule/main.dart';
import 'availability/main.dart';

class TimeTablePage extends StatelessWidget {
  TimeTablePage({Key key, this.secPage = false}) : super(key: key);
  final bool secPage;

  final Tab _scheduleTab = new Tab(
    text: "Schedule",
  );
  final Tab _ttTab = new Tab(
    text: "Availability",
  );

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        initialIndex: secPage ? 1 : 0,
        child: new Scaffold(
          appBar: new AppBar(
            elevation: 1.0,
            backgroundColor: MAINAPPBARCOLOR,
            iconTheme: IconThemeData(color: MAINHEADTEXTCOLOR),
            centerTitle: true,
            title: new Text(
              "Timetable",
              style: new TextStyle(
                  color: MAINHEADTEXTCOLOR,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            bottom: new TabBar(
              indicatorColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
              labelColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
              unselectedLabelColor: MAINHEADTEXTCOLOR.withOpacity(0.5),
              labelStyle: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MAINHEADTEXTCOLOR),
              unselectedLabelStyle: new TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
              tabs: [_scheduleTab, _ttTab],
            ),
          ),
          body: new TabBarView(
            children: [new ScheduleTimeTable(), new AvailTimeTable()],
          ),
        ));
  }
}
