import 'package:flutter/material.dart';
import 'widgets.dart';
import '../../../globalSettings.dart';

class StudentCourse extends StatelessWidget {
  const StudentCourse({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
          style: new TextStyle(
              color: MAINHEADTEXTCOLOR,
              fontSize: 25,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(
              Icons.navigate_before,
              color: MAINHEADTEXTCOLOR,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: MAINAPPBARCOLOR,
        elevation: 1,
      ),
      body: new ListView(
        padding: EdgeInsets.only(top: 15, bottom: 50),
        children: [new ClassStats()],
      ),
    );
  }
}
