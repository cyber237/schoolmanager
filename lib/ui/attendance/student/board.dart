import 'package:flutter/material.dart';
import 'widgets.dart';
import '../../../globalSettings.dart';

class StudentBoard extends StatelessWidget {
  const StudentBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          head(),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          AttendanceChart(
            large: false,
          ),
          DashBoard(
            width: _screenWidth * 0.9,
            large: true,
          )
        ],
      ),
    );
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
