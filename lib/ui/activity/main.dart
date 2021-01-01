import 'package:flutter/material.dart';
import '../../globalSettings.dart';

class Activity extends StatelessWidget {
  const Activity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
          child: new Text(
        "ACTIVITY Coming Soon",
        style: comingSoonStyle,
      )),
    );
  }
}
