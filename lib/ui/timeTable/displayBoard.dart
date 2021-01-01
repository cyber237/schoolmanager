import 'package:flutter/material.dart';
import '../../globalSettings.dart';
import 'package:flutter/gestures.dart';

class DisplayBoard extends StatelessWidget {
  DisplayBoard(
      {Key key, this.data, @required this.width, @required this.maximized})
      : super(key: key);
  final Map data;
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
    return new Container(
        width: width,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: new Card(
          elevation: 10,
          color: Colors.grey.shade50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: new Column(
            children: [
              _field(context,
                  dataField: data["startTime"] + " - " + data["stopTime"],
                  headText: true,
                  first: true),
              _field(context, dataField: data["courseInfo"], headText: false),
              Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              _field(context, dataField: data["lecturerName"], headText: false),
              Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              _field(context,
                  dataField: data["venue"], headText: false, last: true)
            ],
          ),
        ));
  }

  Widget _field(BuildContext context,
      {String dataField,
      bool headText = false,
      bool last = false,
      bool first = false}) {
    final double _screenWidth = MediaQuery.of(context).size.width;
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
        child: ListView(
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
                child: !headText
                    ? new Text(
                        dataField.isEmpty ? "" : dataField.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: maximized ? _maxTextStyle : _minTextStyle,
                        softWrap: false,
                      )
                    : new Text(
                        dataField.toUpperCase(),
                        textAlign: TextAlign.center,
                        softWrap: false,
                        style: new TextStyle(
                            fontSize: maximized ? 25 : 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
              )
            ]));
  }
}
