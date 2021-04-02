import 'dart:ui';
import 'package:flutter/painting.dart';

import '../../../logic/lecturer/db_models/attendance/course.dart';
import '../../../logic/lecturer/states/attendance.dart';
import 'package:flutter/material.dart';
import '../../../globalSettings.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class BottomBoard extends StatelessWidget {
  BottomBoard({Key key}) : super(key: key);
  final TextStyle _countStyle = new TextStyle(
      height: 1.1,
      fontSize: 45,
      fontWeight: FontWeight.w900,
      color: Colors.green);
  final TextStyle _normStyle = new TextStyle(
      height: 1.2,
      fontSize: 35,
      fontWeight: FontWeight.w400,
      color: Colors.blueGrey.shade400);

  @override
  Widget build(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;

    return new Container(
        alignment: Alignment.center,
        width: _screenwidth * 0.95,
        height: 250,
        child: new Column(children: [
          new Text.rich(
            TextSpan(text: "33", style: _countStyle, children: [
              new TextSpan(
                  text: " Attendances\nconducted in \n", style: _normStyle),
              new TextSpan(text: "4 ", style: _countStyle),
              new TextSpan(text: "Courses", style: _normStyle)
            ]),
            textAlign: TextAlign.center,
          ),
          new Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: new ElevatedButton(
              child: new Text("Take/History Attendance"),
              style: new ButtonStyle(
                  animationDuration: Duration(milliseconds: 200),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade900),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                  minimumSize: MaterialStateProperty.all(new Size(200, 60)),
                  textStyle: MaterialStateProperty.all(new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white))),
              onPressed: () => null,
            ),
          )
        ]));
  }
}

class CourseBoard extends StatelessWidget {
  CourseBoard({@required this.course});
  final Course course;
  final BorderRadius _borderRadius = BorderRadius.circular(30);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: new Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: new BoxDecoration(
            borderRadius: _borderRadius,
          ),
          child: new Column(
            children: [head(context: context), bottom(context)],
          ),
        ),
      ),
    );
  }

  Widget head({BuildContext context}) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.9,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                "course:  ${course.name.replaceRange(0, 1, course.name[0].toUpperCase())}",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(
                    fontSize: 20,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                    color: MAINHEADTEXTCOLOR.withOpacity(0.7)),
              ),
              new Text(
                "code:  " + course.id,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(
                    fontSize: 22,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: MAINHEADTEXTCOLOR.withOpacity(0.5)),
              )
            ]));
  }

  Widget bottom(BuildContext context) {
    return new Container(
      child: new Column(
        children: [
          section(context,
              left: "speciality:  " + course.level.speciality.id,
              right: "department:  " + course.level.speciality.department),
          section(context, left: course.level.name, right: course.level.id),
        ],
      ),
    );
  }

  Widget section(BuildContext context, {String left, String right}) {
    final double _boxWidth = MediaQuery.of(context).size.width * 0.4;
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Container(
              width: _boxWidth,
              child: new Text(
                "$left",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(fontSize: 20, color: Colors.black),
              )),
          new Container(
              width: _boxWidth,
              child: new Text(
                "$right",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(fontSize: 17, color: Colors.black),
              )),
        ],
      ),
    );
  }
}
