import 'dart:async';
import '../../../logic/database/timetable.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../home/homeGlobalsettings.dart';
import '../../../globalSettings.dart';
import 'displayBoard.dart';
import 'main.dart';
import '../../../logic/db_models/timetable/timetable.dart';
import '../../../logic/services/network_connection/networkConnectivity.dart';
import '../../../logic/services/timetable/network_feedback.dart';
import 'widgets.dart';

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
  final DateTime todayDate = DateTime.now();

  final NetworkConnectivityFeedBack networkFeed =
      new NetworkConnectivityFeedBack();

  final SnackBar noTTsnack = new SnackBar(
    content:
        new Text("Sorry! No Timetables Yet\nContact Coordinator for more info"),
    duration: Duration(seconds: 1),
  );
  bool noTTswitch = false;
  SnackBar notConnected;
  NetworkConnectivity netConnect = new NetworkConnectivity();

  final List<String> dayList = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun"
  ];
  List<Period> todayData;

  // stores true if there is a time table in memory
  bool ttLoaded = false;
  TimeTableDefault ttDefault = new TimeTableDefault();
  List<TimeTable> timeTables = tts;
  Timer noTTanimator = new Timer.periodic(Duration(minutes: 1), (timer) {});

  @override
  void initState() {
    ttDefault.getTimeTable().whenComplete(() {
      if (mounted) {
        setState(() {
          timeTables = ttDefault.timeTables;
          ttLoaded = timeTables != null && timeTables.isNotEmpty;
          todayData = getTodayData(tts: timeTables);
        });
      }
    });

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
    debugPrint("tt Length= ${timeTables.length}");

    // Initialise today's timetable Schedule
    //   * get current week TimeTable
    //   * get day like {mon or tue } of today's DateTime Object
    //   * get the data of that day from the current week TimeTable

    super.initState();
  }

  @override
  void dispose() {
    if (noTTanimator.isActive) {
      noTTanimator.cancel();
    }

    ttLoaded = !(timeTables == null || timeTables.length < 1);
    todayData = ttLoaded ? getTodayData() : null;
    Future.delayed(Duration(seconds: 1), () {
      todayData ?? animateTTerror(context);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TimeTableDB ttDB = Provider.of<TimeTableDB>(context);
    setState(() {
      timeTables = ttDB.timeTables ?? ttDefault.timeTables;
      ttLoaded = timeTables != null && timeTables.isNotEmpty;
      todayData = getTodayData(tts: timeTables);
    });

    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _screenWidth > 400 ? _screenWidth * 0.8 : _screenWidth * 0.9,
      child: new InkWell(
        onTap: () {
          // If time table Loaded DO:
          debugPrint("TTLOADED : $ttLoaded");
          if (ttLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new StudentTimeTable()),
            );
          } else {
            netConnect.checkOnlineStatus().then((value) {
              if (value) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noTTsnack);
              } else {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(notConnected);
              }
            });
          }
        },
        child: new Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 5,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _timeTableHead(),
              _horizontalHeadDivider,
              _date(),
              todayData != null
                  ? _dataBox(context: context, dataList: todayData)
                  : _noWeekTimeTable()
            ],
          ),
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
        "TIME TABLE",
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
                "${dayList[todayDate.weekday - 1].toUpperCase()}",
                style: _dateStyle,
              ),
              new VerticalDivider(),
              new Text(
                todayDate
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

  Widget _dataBox({BuildContext context, List dataList}) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _boxWidth = _screenWidth * cardwidthRatio;
    return new Container(
      width: _screenWidth > 400 ? _screenWidth * 0.8 : _screenWidth * 0.9,
      height: ttLoaded ? 230 : 150,
      padding: EdgeInsets.only(bottom: 5),
      child: new ListView(
        padding: EdgeInsets.only(bottom: 10),
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        scrollDirection: Axis.horizontal,
        children: dataList
            .map((value) => DisplayBoard(
                  period: value,
                  width: _boxWidth * 0.65,
                  maximized: false,
                ))
            .toList(),
      ),
    );
  }

  Widget _noWeekTimeTable() {
    return new AnimatedContainer(
        duration: Duration(seconds: 1),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            border: Border.all(color: noTTswitch ? Colors.blue : Colors.red)),
        child: new Center(
          child: new ListTile(
            leading: new Icon(Icons.error, color: Colors.red, size: 40),
            title: new Text("No week timetable Found",
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500)),
            subtitle: new Text("Check Internet Connection",
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade400)),
          ),
        ));
  }

  void animateTTerror(BuildContext context) {
    noTTanimator = new Timer.periodic(Duration(seconds: 1), (timer) {
      try {
        if (mounted) {
          setState(() {
            noTTswitch = !noTTswitch;
          });
        }
      } catch (e) {
        debugPrint("Animate TT ERRor ::: $e");
      }
    });
  }

  List<Period> getTodayData({List<TimeTable> tts}) {
    final List ll = Shared().getCurrentWeek(fullData: tts);
    final TimeTable tt = ll != null ? ll[0] as TimeTable : null;
    return tt != null ? tt.periods[todayDate.day - 1] : null;
  }
}
