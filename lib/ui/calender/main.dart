import 'package:flutter/material.dart';
import 'calenderSection.dart';
import '../../globalSettings.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        backgroundColor: MAINAPPBARCOLOR,
        centerTitle: true,
        title: new Text("CALENDER",
            style: new TextStyle(fontSize: 20, color: MAINHEADTEXTCOLOR)),
        leading: new IconButton(
          icon: new Icon(Icons.navigate_before,
              size: 30, color: MAINHEADTEXTCOLOR),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.settings, size: 30, color: MAINHEADTEXTCOLOR),
            onPressed: () => null,
          ),
        ],
      ),
      body: new ListView(children: [CalenderSection()]),
    ));
  }
}
