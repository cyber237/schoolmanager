import 'dart:ui';
import '../../../logic/db_models/attendance/lecturer/speciality.dart';

import 'package:flutter/material.dart';
import '../../../globalSettings.dart';

class MiniBoard extends StatelessWidget {
  const MiniBoard({Key key, @required this.customBoard, @required this.title})
      : super(key: key);
  final Widget customBoard;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Card(
        child: new Column(
          children: [head(context, title), customBoard],
        ),
      ),
    );
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
              )),
          MiniBoard(
            title: "Past\nRecords",
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

class SpecialityBoard extends StatelessWidget {
  SpecialityBoard({@required this.speciality});
  final Speciality speciality;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
        child: new Container(
          child: new Column(
            children: [head(context: context), levelBoard()],
          ),
        ),
      ),
    );
  }

  Widget head({BuildContext context}) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.4,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: new Column(children: [
          new Text(
            speciality.name,
            style: new TextStyle(
                fontSize: 25,
                height: 2.0,
                fontWeight: FontWeight.w500,
                color: MAINHEADTEXTCOLOR.withOpacity(0.7)),
          ),
          new Text(
            speciality.department,
            style: new TextStyle(
                fontSize: 22,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: MAINHEADTEXTCOLOR.withOpacity(0.5)),
          )
        ]));
  }

  Widget levelBoard() {
    return new Container(
      child: new Column(
        children: speciality.levels.map((e) => level(e)).toList(),
      ),
    );
  }

  Widget level(Level l) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [MAINHEADTEXTCOLOR, Colors.white70], stops: [0.7, 0.8]),
      ),
      child: new Column(
        children: [
          new Text(
            "Level ${l.name}",
            style: new TextStyle(fontSize: 20, color: Colors.white),
          ),
          new Text(
            "${l.students.length} Students",
            style: new TextStyle(fontSize: 17, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
