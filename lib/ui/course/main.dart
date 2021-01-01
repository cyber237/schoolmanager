import 'package:flutter/material.dart';
import '../../globalSettings.dart';

class Course extends StatelessWidget {
  const Course({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
          child: new Text(
        "COURSE Coming Soon",
        style: comingSoonStyle,
      )),
    );
  }
}
