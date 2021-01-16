import 'package:flutter/material.dart';
import '../../globalSettings.dart';
import 'main.dart';

class AttendanceBoard extends StatelessWidget {
  const AttendanceBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * cardwidthRatio,
        height: 300,
        child: new InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Attendance())),
            child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                elevation: 5,
                child: new Container(
                  child: new Center(child: new Text("ATTENDANCE")),
                ))));
  }
}
