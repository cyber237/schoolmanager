import 'package:flutter/material.dart';
import 'widgets.dart';
import '../../../globalSettings.dart';

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new OverallAttendance(),
          DashBoard(),
          Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          CoursesDiagnostics()
        ],
      ),
    );
  }
}

class Attendance extends StatelessWidget {
  const Attendance({Key key}) : super(key: key);

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
      body: new Student(),
    );
  }
}
