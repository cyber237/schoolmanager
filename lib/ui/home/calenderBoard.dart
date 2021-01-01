import 'package:flutter/material.dart';
import '../../globalSettings.dart';
import 'homeGlobalsettings.dart';
import '../calender/main.dart';

class CalenderBoard extends StatelessWidget {
  const CalenderBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    Map<String, String> _quickCalenderData = {
      "yesterday": "",
      "today": "Delegue Meetings",
      "tomorrow": ""
    };

    return Container(
        width: _screenWidth * cardwidthRatio,
        child: new InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CalenderPage())),
          child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            elevation: 5,
            child: new Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _head(),
                  Divider(
                    endIndent: 80,
                    indent: 70,
                    thickness: 1.5,
                  ),
                  _eventDisplayer(
                      context, "yesterday", _quickCalenderData["yesterday"]),
                  SizedBox(
                      height: 1,
                      width: 100,
                      child: new Container(
                        color: Colors.grey.shade100,
                      )),
                  _eventDisplayer(
                      context, "today", _quickCalenderData["today"]),
                  SizedBox(
                      height: 1,
                      width: 100,
                      child: new Container(
                        color: Colors.grey.shade100,
                      )),
                  _eventDisplayer(
                      context, "tomorrow", _quickCalenderData["tomorrow"]),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _head() {
    Widget _headText = new Text(
      "CALENDER",
      style: new TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
    );

    Widget _icon = new Icon(
      Icons.notifications,
      size: 30,
      color: MAINHEADTEXTCOLOR.withOpacity(0.8),
    );

    return new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _headText,
            _icon,
          ],
        ));
  }

  Widget _eventDisplayer(BuildContext context, String date, String event) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    final TextStyle _dateStyle = new TextStyle(
        fontSize: 19, fontWeight: FontWeight.w600, color: Colors.grey.shade600);
    final TextStyle _eventStyle = new TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey.shade700);
    return new Container(
        width: double.infinity,
        //height: N,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            new Container(
                width: _screenwidth * cardwidthRatio / 2,
                child: new Text(
                  date.toUpperCase(),
                  style: _dateStyle,
                )),
            new Container(
                width: _screenwidth * cardwidthRatio / 2,
                child: new Text(
                  event.isEmpty ? "No event" : event,
                  style: _eventStyle,
                ))
          ],
        ));
  }
}
