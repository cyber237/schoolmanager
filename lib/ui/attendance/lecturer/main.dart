import 'package:flutter/material.dart';
import 'widgets.dart';
import '../../../logic/lecturer/states/attendance.dart';
import 'package:provider/provider.dart';
//import '../../../logic/db_models/attendance/lecturer/course.dart';
import '../../../globalSettings.dart';

class TakeAttendance extends StatelessWidget {
  const TakeAttendance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: MAINAPPBARCOLOR,
        elevation: 1.0,
        title: new Text(
          "Attendance",
          style: new TextStyle(
              color: MAINHEADTEXTCOLOR,
              fontSize: 25,
              fontWeight: FontWeight.w400),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.navigate_before_sharp),
            color: MAINHEADTEXTCOLOR,
            iconSize: 35,
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
      ),
      body: new AttendanceHistory(),
    );
  }
}

class AttendanceHistory extends StatelessWidget {
  final Widget loading = new Center(
      child: Container(
    width: 100,
    height: 100,
    child: CircularProgressIndicator(),
  ));
  @override
  Widget build(BuildContext context) {
    var upStream = Provider.of<AttendanceHistoryState>(context);
    return new Scaffold(
      body: upStream.data.isEmpty
          ? loading
          : new ListView(
              children:
                  upStream.data.map((e) => CourseBoard(course: e)).toList(),
            ),
    );
  }
}
