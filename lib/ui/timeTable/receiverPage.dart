import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:schoolmanager/globalSettings.dart';
import 'dart:async';
import 'displayBoard.dart';
//import '../../data_in_memory/data_ui.dart';

class StudentTimeTable extends StatefulWidget {
  StudentTimeTable({Key key, this.hNetworkStream, this.data}) : super(key: key);

  final StreamSubscription hNetworkStream;
  final List data;

  @override
  _StudentTimeTableState createState() => _StudentTimeTableState();
}

class _StudentTimeTableState extends State<StudentTimeTable> {
  int index = 0;
  StreamSubscription bStream;

  @override
  void initState() {
    widget.hNetworkStream.pause();
    super.initState();
  }

  @override
  void dispose() {
    widget.hNetworkStream.resume();
    //bStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${widget.data.length}");
    return new MaterialApp(
        home: Scaffold(
      appBar: new AppBar(
        backgroundColor: MAINAPPBARCOLOR,
        centerTitle: true,
        title: new Text("TIME TABLE",
            style: new TextStyle(fontSize: 20, color: MAINHEADTEXTCOLOR)),
        leading: new IconButton(
          icon:
              new Icon(Icons.chevron_left, size: 30, color: MAINHEADTEXTCOLOR),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.list, size: 30, color: MAINHEADTEXTCOLOR),
            onPressed: () => null,
          ),
        ],
      ),
      body: new ListView(
        children: [
          _weekSlides(),
          TimeTable(week: _arrangeData(widget.data[index]))
        ],
      ),
    ));
  }

  Widget _weekSlides() {
    BaseWeekObj weekData = _arrangeData(widget.data[index]);
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 60,
        child: new Swiper(
          outer: true,
          loop: false,
          onIndexChanged: (ind) => setState(() => index = ind),
          control: SwiperControl(color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
          itemCount: widget.data.length,
          containerHeight: double.infinity,
          itemBuilder: (context, index) {
            return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: new Text(weekData.weekName,
                    style: new TextStyle(
                        color: MAINHEADTEXTCOLOR,
                        fontSize: 22,
                        fontWeight: FontWeight.w500)));
          },
        ));
  }

  BaseWeekObj _arrangeData(Map<String, dynamic> weekData) {
    BaseWeekObj _arrangedWeekData = new BaseWeekObj();
    List daysweek = weekData["cells"];
    Map weekDates = weekData["week"];
    debugPrint("Num of days ${daysweek.length}");
    String firstDate = getDate(
        new DateTime.fromMillisecondsSinceEpoch(weekDates["firstDay"].toInt()));

    String lastDate = getDate(
        new DateTime.fromMillisecondsSinceEpoch(weekDates["lastDay"].toInt()));

    _arrangedWeekData.weekName = firstDate + " / " + lastDate;
    _arrangedWeekData.mon = daysweek.elementAt(0);
    _arrangedWeekData.tue = daysweek.elementAt(1);
    _arrangedWeekData.wed = daysweek.elementAt(2);
    _arrangedWeekData.thu = daysweek.elementAt(3);
    _arrangedWeekData.fri = daysweek.elementAt(4);
    _arrangedWeekData.sat = daysweek.elementAt(5);
    _arrangedWeekData.sun = daysweek.elementAt(6);
    return _arrangedWeekData;
  }

  String getDate(DateTime date) {
    String newForm = (date.day.toString().length < 2
            ? "0" + date.day.toString()
            : date.day.toString()) +
        "-" +
        (date.month.toString().length < 2
            ? "0" + date.month.toString()
            : date.month.toString()) +
        "-" +
        date.year.toString();
    return newForm;
  }
}

class TimeTable extends StatefulWidget {
  TimeTable({Key key, this.week}) : super(key: key);
  final BaseWeekObj week;

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final List<String> _weekDays = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun"
  ];

  int _dayInfoCus = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: new Column(
        children: [
          _daySlider(context),
          _dataDisplay(_weekDays[_dayInfoCus], context)
        ],
      ),
    );
  }

  Widget _dataDisplay(String day, BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final Map dataMap = {
      "mon": widget.week.mon,
      "tue": widget.week.tue,
      "wed": widget.week.wed,
      "thu": widget.week.thu,
      "fri": widget.week.fri,
      "sat": widget.week.sat,
      "sun": widget.week.sun,
    };
    List<Widget> children = [];
    for (int i = 1; i <= dataMap[day].length; i++) {
      children.add(DisplayBoard(
        data: dataMap[day][i - 1],
        width: _screenWidth * 0.9,
        maximized: true,
      ));
    }
    return new Column(
      children: children,
    );
  }

  Widget _daySlider(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth,
        height: 70,
        child: new ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          children: _weekDays.map((day) => _dayPick(day)).toList(),
        ));
  }

  Widget _dayPick(String day) {
    int _indexOfDay = _weekDays.indexOf(day);
    bool active = _indexOfDay == _dayInfoCus;
    Color _buttColor = active ? MAINHEADTEXTCOLOR : null;
    Color _textColor = active ? Colors.white : MAINHEADTEXTCOLOR;
    return new GestureDetector(
      onTap: () {
        if (!(active)) {
          setState(() => _dayInfoCus = _indexOfDay);
        }
      },
      child: new Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 60,
          decoration: new BoxDecoration(
              border: Border.all(color: MAINHEADTEXTCOLOR),
              color: _buttColor,
              borderRadius: BorderRadius.circular(10)),
          child: new Text(day.toUpperCase(),
              style: new TextStyle(
                  fontSize: 15,
                  color: _textColor,
                  fontWeight: FontWeight.w600))),
    );
  }
}

class BaseWeekObj {
  String weekName;
  List mon;
  List tue;
  List wed;
  List thu;
  List fri;
  List sat;
  List sun;
}
