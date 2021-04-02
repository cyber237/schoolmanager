import 'package:flutter/material.dart';
import '../../../globalSettings.dart';
import 'dart:async';
import 'package:schoolmanager/logic/shared/services/network_connection/networkConnectivity.dart';
import 'package:schoolmanager/logic/lecturer/services/reqs/timetable/network_feedback.dart';
import 'package:schoolmanager/logic/lecturer/services/reqs/timetable/connection.dart';
import 'main.dart';

class TimeTableBoard extends StatefulWidget {
  const TimeTableBoard({Key key, this.homeNetworkSubscription})
      : super(key: key);
  final StreamSubscription homeNetworkSubscription;
  @override
  State<StatefulWidget> createState() => TimeTableBoardState();
}

class TimeTableBoardState extends State<TimeTableBoard> {
  final Widget _horizontalHeadDivider = const Divider(
    indent: 40,
    endIndent: 40,
    thickness: 1.5,
  );

  final NetworkConnectivityFeedBack networkFeed =
      new NetworkConnectivityFeedBack();

  final SnackBar noTTsnack = new SnackBar(
    content:
        new Text("Sorry! No Timetables Yet\nContact Coordinator for more info"),
    duration: Duration(seconds: 1),
  );
  SnackBar notConnected;
  NetworkConnectivity netConnect = new NetworkConnectivity();

  TimeTableConnection ttDefault = new TimeTableConnection();

  @override
  void initState() {
    ttDefault.getTimeTable().whenComplete(() {});

    //Initialise not Connected SnackBar
    notConnected = new SnackBar(
        content:
            new Text("Couldn't connect to server\nCheck connection and retry"),
        duration: Duration(seconds: 3),
        action: new SnackBarAction(
            label: "Retry",
            onPressed: () =>
                networkFeed.retryTimeTable(context, notConnected)));

    Future.delayed(Duration(seconds: 1), () {
      netConnect.connectionStatusController.stream.listen((event) {
        networkFeed.retryTimeTable(context, notConnected);
      });
    });

    // Initialise today's timetable Schedule
    //   * get current week TimeTable
    //   * get day like {mon or tue } of today's DateTime Object
    //   * get the data of that day from the current week TimeTable

    super.initState();
  }

  final List<String> _dayList = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun"
  ];
  final DateTime _todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
      width: _screenWidth * cardwidthRatio,
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: new InkWell(
        child: new Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          elevation: 5,
          child: new Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: new Column(
                children: [
                  _timeTableHead(),
                  _horizontalHeadDivider,
                  _date(),
                  _SubBoard()
                ],
              )),
        ),
      ),
    );
  }

  Widget _timeTableHead() {
    return new Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: new Text(
        "TIMETABLE",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: MAINHEADTEXTCOLOR.withOpacity(0.8),
            letterSpacing: 1.3,
            height: 1.5),
      ),
    );
  }

  Widget _date() {
    final TextStyle _dayStyle = new TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: MAINHEADTEXTCOLOR.withOpacity(0.7),
        letterSpacing: 1.2,
        height: 1.2);
    final TextStyle _dateStyle = new TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: MAINHEADTEXTCOLOR.withOpacity(0.8),
        letterSpacing: 1.2,
        height: 1.2);
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new Text(
            "Today",
            style: _dayStyle,
          ),
          new Container(
              child: new Row(
            children: [
              new Text(
                "${_dayList[_todayDate.weekday - 1].toUpperCase()}",
                style: _dateStyle,
              ),
              new VerticalDivider(),
              new Text(
                _todayDate
                    .toIso8601String()
                    .split(":")[0]
                    .split("T")[0]
                    .toString(),
                style: _dateStyle,
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class _SubBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.95,
        height: 180,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: [
            MiniBoard(
                customBoard: new Icon(Icons.schedule,
                    size: 60, color: MAINHEADTEXTCOLOR.withOpacity(0.9)),
                title: "Week\nSchedule",
                titleColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
                page: new TimeTablePage()),
            MiniBoard(
                customBoard: new Icon(Icons.lock_clock,
                    size: 60, color: Colors.green.shade900),
                title: "Availability\nSchedule",
                titleColor: Colors.green.shade800,
                page: new TimeTablePage(
                  secPage: true,
                )),
          ],
        ));
  }
}

class MiniBoard extends StatelessWidget {
  const MiniBoard(
      {Key key,
      @required this.customBoard,
      @required this.title,
      @required this.titleColor,
      @required this.page})
      : super(key: key);
  final Widget customBoard;
  final Color titleColor;
  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;

    return Container(
        width: _screenwidth * 0.46,
        child: new InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => page)),
          child: new Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [customBoard, head(context, title)],
            ),
          ),
        ));
  }

  Widget head(BuildContext context, String head) {
    return new Container(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: new Text(
      head.toUpperCase(),
      textAlign: TextAlign.center,
      style: new TextStyle(
          fontSize: 22, color: titleColor, fontWeight: FontWeight.w800),
    ));
  }
}
