import 'dart:ui';
import '../../../logic/lecturer/db_models/attendance/course.dart';
import '../../../logic/lecturer/states/attendance.dart';
import 'package:flutter/material.dart';
import '../../../globalSettings.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class MiniBoard extends StatelessWidget {
  const MiniBoard(
      {Key key,
      @required this.customBoard,
      @required this.title,
      @required this.page})
      : super(key: key);
  final Widget customBoard;
  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => page)),
      child: new Card(
        child: new Column(
          children: [head(context, title), customBoard],
        ),
      ),
    ));
  }

  Widget head(BuildContext context, String head) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: _screenwidth * 0.5,
        child: new Text(
          head.toUpperCase(),
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: 23, color: Colors.black54, fontWeight: FontWeight.w900),
        ));
  }
}

class BottomBoard extends StatelessWidget {
  const BottomBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
      width: _screenwidth * 0.95,
      height: 200,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MiniBoard(
            title: "Take\nAttendance",
            customBoard: new Icon(
              Icons.bar_chart,
              color: Colors.lightBlueAccent.shade700,
              size: 100,
            ),
            page: new ChangeNotifierProvider(
                builder: (context) => AttendanceHistoryState(),
                child: new TakeAttendance()),
          ),
          MiniBoard(
            title: "Past\nRecords",
            page: new ChangeNotifierProvider(
                builder: (context) => AttendanceHistoryState(),
                child: new AttendanceHistory()),
            customBoard: new Icon(
              Icons.history,
              color: Colors.lightBlueAccent.shade700,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseBoard extends StatelessWidget {
  CourseBoard({@required this.course});
  final Course course;
  final BorderRadius _borderRadius = BorderRadius.circular(30);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: new Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: new BoxDecoration(
            borderRadius: _borderRadius,
            gradient: new LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  MAINHEADTEXTCOLOR.withOpacity(0.7),
                  MAINHEADTEXTCOLOR.withOpacity(0.6),
                  MAINHEADTEXTCOLOR.withOpacity(0.5),
                  Colors.white70
                ],
                stops: [
                  0.05,
                  0.15,
                  0.3,
                  1
                ]),
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
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                "course: ${course.name.replaceRange(0, 1, course.name[0].toUpperCase())}",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(
                    fontSize: 25,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                    color: MAINHEADTEXTCOLOR.withOpacity(0.7)),
              ),
              new Text(
                course.id,
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
              left: course.level.speciality.name,
              right: course.level.speciality.department),
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
                style: new TextStyle(fontSize: 20, color: Colors.white),
              )),
          new Container(
              width: _boxWidth,
              child: new Text(
                "$right",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: new TextStyle(fontSize: 17, color: Colors.white),
              )),
        ],
      ),
    );
  }
}
