import 'package:flutter/material.dart';
import 'package:schoolmanager/ui/attendance/lecturer/widgets.dart';
import '../../../globalSettings.dart';

class AttendanceBoard extends StatelessWidget {
  const AttendanceBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * cardwidthRatio,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: 300,
        child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            elevation: 5,
            child: new Container(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // head(),
                  // Divider(
                  //   indent: 20,
                  //   endIndent: 20,
                  // ),
                  new BottomBoard()
                ],
              ),
            )));
  }

  Widget head() {
    return new Container(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 5,
        ),
        child: new Text(
          "ATTENDANCE",
          style: new TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
        ));
  }
}
