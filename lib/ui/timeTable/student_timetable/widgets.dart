import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'displayBoard.dart';
import '../../../globalSettings.dart';
import '../../../logic/db_models/timetable/timetable.dart';
import '../../../logic/database/timetable.dart';
import 'studentState.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Shared {
  final List<String> weekDays = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun"
  ];

  final List<String> monthList = [
    "jan",
    "feb",
    "mar",
    "apr",
    "may",
    "june",
    "jul",
    "aug",
    "sep",
    "oct",
    "nov",
    "dec"
  ];

  List<dynamic> getCurrentWeek({List<TimeTable> fullData}) {
    DateTime now = DateTime.now();
    if (now.weekday != 1) {
      now = now.subtract(new Duration(days: now.weekday - 1));
    }

    DateTime thisWeekStartDate = new DateTime(now.year, now.month, now.day);
    debugPrint("Shared week Start: ${now.day}");
    int i = 0;
    final List<TimeTable> ttL = fullData ?? tts;
    for (TimeTable tt in ttL) {
      DateTime firstDate =
          DateTime.fromMillisecondsSinceEpoch(tt.weekInfo["firstDay"].toInt());
      if (validateDates(firstDate, thisWeekStartDate)) {
        return [tt, i];
      }
      i += 1;
    }
    return null;
  }

  bool validateDates(DateTime firstDate, DateTime secondDate) {
    if (firstDate.day == secondDate.day &&
        firstDate.month == secondDate.month &&
        firstDate.year == secondDate.year) {
      return true;
    }
    return false;
  }
}

class WeekSlides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final upStream = Provider.of<TimeTableNotifier>(context);
    final List<TimeTable> fullData = upStream.fullData;

    final TextStyle _labelStyle = new TextStyle(
        color: MAINHEADTEXTCOLOR, fontSize: 18, fontWeight: FontWeight.w400);
    Text _aliasLabel = new Text(upStream.ttAlias,
        textAlign: TextAlign.center, style: _labelStyle);
    Text _upperAlias;
    Text _lowerAlias;

    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 60,
        child: new Swiper(
          outer: true,
          fade: 0.2,
          duration: 500,
          index: upStream.ttIndex,
          onIndexChanged: (ind) {
            upStream.ttIndex = ind;
          },
          control: SwiperControl(
              color: MAINHEADTEXTCOLOR.withOpacity(0.8),
              size: 20,
              disableColor: Colors.grey.shade400),
          itemCount: fullData.length,
          containerHeight: double.infinity,
          loop: false,
          itemBuilder: (context, index) {
            if (upStream.ttAlias.contains("\n")) {
              _upperAlias = new Text(
                upStream.ttAlias.split("\n")[0],
                textAlign: TextAlign.center,
                style: _labelStyle,
              );
              _lowerAlias = new Text(
                upStream.ttAlias.split("\n")[1],
                textAlign: TextAlign.center,
                style: _labelStyle,
              );
            }
            return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: upStream.data.prevVersion != null &&
                        upStream.ttAlias.contains("\n")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: ClipOval(
                                        child: new Container(
                                          width: 10,
                                          height: 10,
                                          color: Colors.red,
                                        ),
                                      )),
                                  _upperAlias
                                ]),
                            _lowerAlias
                          ])
                    : _aliasLabel);
          },
        ));
  }
}

class TimeTableDisplay extends StatelessWidget {
  final List<String> _weekDays = Shared().weekDays;
  @override
  Widget build(BuildContext context) {
    var upStream = Provider.of<TimeTableNotifier>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: new Column(
        children: [
          DayPicker(),
          _dataDisplay(_weekDays[upStream.dayInfocus], context)
        ],
      ),
    );
  }

  Widget _dataDisplay(String day, BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final BaseWeekObj week =
        new BaseWeekObj(Provider.of<TimeTableNotifier>(context).data);

    final Map dataMap = {
      "mon": week.mon,
      "tue": week.tue,
      "wed": week.wed,
      "thu": week.thu,
      "fri": week.fri,
      "sat": week.sat,
      "sun": week.sun,
    };
    List<Widget> children = [];
    for (int i = 1; i <= dataMap[day].length; i++) {
      children.add(DisplayBoard(
        period: dataMap[day][i - 1],
        width: _screenWidth * 0.9,
        maximized: true,
      ));
    }
    return new Column(
      children: children,
    );
  }
}

class DayPicker extends StatelessWidget {
  final List<String> weekDays = Shared().weekDays;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth,
        height: 70,
        child: new ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          children: weekDays.map((day) => _dayPick(day, context)).toList(),
        ));
  }

  Widget _dayPick(String day, BuildContext context) {
    final upStream = Provider.of<TimeTableNotifier>(context);
    int _indexOfDay = weekDays.indexOf(day);
    bool active = _indexOfDay == upStream.dayInfocus;
    Color _buttColor = active ? MAINHEADTEXTCOLOR : null;
    Color _textColor = active ? Colors.white : MAINHEADTEXTCOLOR;
    return new GestureDetector(
      onTap: () {
        if (!(active)) {
          upStream.dayInfocus = _indexOfDay;
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
  BaseWeekObj(this.weekData) {
    _arrangeData(weekData);
  }
  final TimeTable weekData;
  String weekName;
  List mon;
  List tue;
  List wed;
  List thu;
  List fri;
  List sat;
  List sun;
  int firstDate;
  int lastDate;

  void _arrangeData(TimeTable weekData) {
    List daysweek = weekData.periods;
    Map weekDates = weekData.weekInfo;
    debugPrint("Num of days ${daysweek.length}");
    firstDate = weekDates["firstDay"];
    lastDate = weekDates["lastDay"];
    mon = daysweek.elementAt(0);
    tue = daysweek.elementAt(1);
    wed = daysweek.elementAt(2);
    thu = daysweek.elementAt(3);
    fri = daysweek.elementAt(4);
    sat = daysweek.elementAt(5);
    sun = daysweek.elementAt(6);
    String firstDateStr =
        getDate(new DateTime.fromMillisecondsSinceEpoch(firstDate));

    String lastDateStr =
        getDate(new DateTime.fromMillisecondsSinceEpoch(lastDate));

    weekName = firstDateStr + " / " + lastDateStr;
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
