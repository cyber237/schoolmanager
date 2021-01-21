import 'package:flutter/material.dart';
import '../../globalSettings.dart';
import 'lecturer/board.dart';
import 'main.dart';

class AttendanceBoard extends StatelessWidget {
  const AttendanceBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * cardwidthRatio,
        margin: EdgeInsets.symmetric(vertical: 20),
        height: 350,
        child: new InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Attendance())),
            child: new Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              elevation: 5,
              child: new LecturerBoard(),
            )));
  }
}
