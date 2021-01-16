import 'package:flutter/material.dart';
import 'widgets.dart';

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [new OverallAttendance(), DashBoard(), CoursesDiagnostics()],
      ),
    );
  }
}
