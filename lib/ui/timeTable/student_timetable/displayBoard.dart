import 'package:flutter/material.dart';
import '../../../globalSettings.dart';
import 'package:flutter/gestures.dart';
import '../../../logic/db_models/timetable/timetable.dart';
import 'widgets.dart';

class DisplayBoard extends StatelessWidget {
  DisplayBoard(
      {Key key, this.period, @required this.width, @required this.maximized})
      : super(key: key);
  final Period period;
  final double width;
  final bool maximized;
  final TextStyle _maxTextStyle = TextStyle(
      fontSize: 19,
      color: Colors.blueGrey.shade700,
      fontWeight: FontWeight.w500);
  final TextStyle _minTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.blueGrey.shade700,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    //final double _screenWidth = MediaQuery.of(context).size.width;
    DateTime dateStart = DateTime.fromMillisecondsSinceEpoch(period.start);
    DateTime dateStop = DateTime.fromMillisecondsSinceEpoch(period.stop);
    String message =
        "Date: ${dateStart.day} ${Shared().weekDays[dateStart.weekday - 1]} ${Shared().monthList[dateStart.month - 1]} ${dateStart.year}\n\n";
    for (String key in period.data.keys) {
      if (key != "start" && key != "stop") {
        message += "${key.toUpperCase()} : ${period.data[key] ?? ""}\n";
      }
    }
    return new Tooltip(
        message: message,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        showDuration: Duration(seconds: 30),
        child: Container(
            width: width,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: new Card(
              elevation: 10,
              color: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: new Column(
                children: [
                  _field(context,
                      dataField: dateStart.hour.toString() +
                          ":" +
                          dateStart.minute.toString() +
                          " - " +
                          dateStop.hour.toString() +
                          ":" +
                          dateStop.minute.toString(),
                      headText: true,
                      first: true),
                  _field(context,
                      dataField: period.courseInfo, headText: false),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),
                  _field(context,
                      dataField: period.lecturerName, headText: false),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),
                  _field(context,
                      dataField: period.venue, headText: false, last: true)
                ],
              ),
            )));
  }

  Widget _field(BuildContext context,
      {String dataField,
      bool headText = false,
      bool last = false,
      bool first = false}) {
    double boxHeight = headText
        ? maximized
            ? 60
            : 40
        : maximized
            ? 50
            : 40;
    double boxWidth = headText
        ? width - 10
        : maximized
            ? dataField.length > 22
                ? width + dataField.length
                : width - 20
            : dataField.length > 15
                ? width + dataField.length
                : width - 20;
    final Text _headText = new Text(
      dataField.toUpperCase(),
      textAlign: TextAlign.center,
      softWrap: false,
      style: new TextStyle(
          fontSize: maximized ? 25 : 16,
          color: Colors.white,
          fontWeight: FontWeight.w600),
    );

    final Text _normField = new Text(
      dataField.isEmpty ? "" : dataField.toUpperCase(),
      textAlign: TextAlign.center,
      style: maximized ? _maxTextStyle : _minTextStyle,
      softWrap: false,
    );
    return new Container(
        width: boxWidth - 1,
        height: boxHeight,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: headText ? MAINHEADTEXTCOLOR : Colors.grey.shade50,
          border: Border.all(
              color: headText ? MAINHEADTEXTCOLOR : Colors.grey.shade50),
          borderRadius: first
              ? new BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))
              : last
                  ? new BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : null,
        ),
        child: checkFieldLength(dataField)
            ? !headText
                ? _normField
                : _headText
            : ListView(
                //itemExtent: 1,
                dragStartBehavior: DragStartBehavior.down,
                scrollDirection: Axis.horizontal,
                children: [
                    new Container(
                      width: boxWidth,
                      height: boxHeight,
                      padding: EdgeInsets.symmetric(
                          vertical: headText ? 10 : 5, horizontal: 5),
                      //width: double.infinity,
                      alignment: Alignment.center,
                      child: !headText ? _normField : _headText,
                    )
                  ]));
  }

  bool checkFieldLength(String field) {
    return field.isEmpty || field.length <= 14;
  }
}
