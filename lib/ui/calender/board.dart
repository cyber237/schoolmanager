import 'package:flutter/material.dart';
import '../../globalSettings.dart';
import 'main.dart';

class CalenderBoard extends StatelessWidget {
  const CalenderBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    Map<String, List> _quickCalenderData = {
      "yesterday": [],
      "today": [{}, {}],
      "tomorrow": []
    };

    return Container(
        width: _screenWidth * cardwidthRatio,
        margin: EdgeInsets.only(top: 20),
        child: new InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => new CalenderPage())),
          child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            elevation: 5,
            child: new Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _head(),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  _eventDisplayer(
                      context, "yesterday", _quickCalenderData["yesterday"]),
                  Divider(
                    endIndent: 100,
                    indent: 100,
                  ),
                  _eventDisplayer(
                      context, "today", _quickCalenderData["today"]),
                  Divider(
                    endIndent: 100,
                    indent: 100,
                  ),
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

  Widget _eventDisplayer(BuildContext context, String date, List events) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    final TextStyle _dateStyle = new TextStyle(
        fontSize: 19, fontWeight: FontWeight.w600, color: Colors.grey.shade700);
    final TextStyle _eventStyle = new TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey.shade700);
    return new Container(
        width: _screenwidth * (_screenwidth > 400 ? 0.65 : 0.7),
        //height: N,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            new Container(
                // width: _screenwidth * cardwidthRatio / 2,
                child: new Text(
              date.toUpperCase(),
              style: _dateStyle,
            )),
            new Container(
                alignment: Alignment.centerLeft,
                // width: _screenwidth * cardwidthRatio / 2,
                child: new Text(
                  events.isEmpty ? "No Events" : "${events.length} Events",
                  textAlign: TextAlign.start,
                  style: _eventStyle,
                ))
          ],
        ));
  }
}
