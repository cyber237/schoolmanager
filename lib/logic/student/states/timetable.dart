import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import '../services/timetable/connection.dart';
import '../db_models/timetable/timetable.dart';

class TimeTableDB extends TimeTableConnection with ChangeNotifier {
  Future<void> getTT() async {
    await getTimeTable();
    debugPrint("Notifying Listeners ::: Listeners? $hasListeners");
    notifyListeners();
  }
}

class TimeTableNotifier with ChangeNotifier {
  static int _today = DateTime.now().weekday - 1;
  List _launchData = Shared().getCurrentWeek() ?? [null, null];
  int _dayInfocus = _today;
  List<TimeTable> _fullData = tts;
  TimeTable _data;
  int _ttIndex;
  String _ttAlias;
  Box b;
  TimeTableNotifier() {
    _data = _launchData[0] ?? tts.last;
    _ttIndex = _launchData[1] ?? _today;
    _updateTTalias();
    Future.delayed(Duration.zero, () async => await load());
  }
  Future<void> load() async {
    b = await Hive.openBox("timetable");
    _fullData = b.values.map((e) => e as TimeTable).toList();
    List _tempData = Shared().getCurrentWeek(fullData: _fullData);
    _ttIndex = _tempData != null ? _tempData[1] : 0;
    _data = _tempData != null ? _tempData[0] : _data;
    _updateTTalias();
    b.watch().listen((event) => reCollectData());
    notifyListeners();
  }

  TimeTable get data => _data;
  set data(TimeTable value) {
    _data = value;

    notifyListeners();
  }

  String get ttAlias => _ttAlias;
  List<TimeTable> get fullData => _fullData;

  void reCollectData() {
    _fullData.clear();
    for (TimeTable tb in b.values) {
      _fullData.add(tb);
    }
    _ttIndex = _fullData.length - 1;
    _data = _fullData.last;
    notifyListeners();
  }

  int get dayInfocus => _dayInfocus;
  set dayInfocus(int value) {
    _dayInfocus = value;
    notifyListeners();
  }

  int get ttIndex => _ttIndex;
  set ttIndex(int value) {
    _ttIndex = value;
    _data = fullData[_ttIndex];
    _updateTTalias();
    notifyListeners();
  }

  void _updateTTalias() {
    //Check TT Range
    BaseWeekObj currentTT = new BaseWeekObj(_fullData[_ttIndex]);
    DateTime now = DateTime.now();
    DateTime thisWeekStartDate;
    debugPrint("Today Day: ${now.day}");
    if (now.weekday != 1) {
      now = now.subtract(new Duration(days: now.weekday - 1));
    }

    thisWeekStartDate = new DateTime(now.year, now.month, now.day);
    debugPrint("This Week Start Day: ${thisWeekStartDate.day}");
    DateTime lastWeekStartDate = thisWeekStartDate.subtract(Duration(days: 7));
    debugPrint("Today Day: ${now.day}");
    DateTime nextWeekStartDate = thisWeekStartDate.add(Duration(days: 7));

    DateTime _ttFirstDate =
        DateTime.fromMillisecondsSinceEpoch(currentTT.firstDate.toInt());
    DateTime _ttLastDate =
        DateTime.fromMillisecondsSinceEpoch(currentTT.lastDate.toInt());

    debugPrint("TT Week first Day: ${_ttFirstDate.day}");
    debugPrint("TT Week last Day: ${_ttLastDate.day}");

    debugPrint(
        "This week last Day :${thisWeekStartDate.add(Duration(days: 5)).day}");

    if (Shared().validateDates(_ttFirstDate, thisWeekStartDate) &&
        Shared().validateDates(
            _ttLastDate, thisWeekStartDate.add(Duration(days: 6)))) {
      _ttAlias = "Current Week\n${currentTT.weekName}";
    } else if (Shared().validateDates(_ttFirstDate, lastWeekStartDate) &&
        Shared().validateDates(
            _ttLastDate, lastWeekStartDate.add(Duration(days: 6)))) {
      _ttAlias = "Last Week\n${currentTT.weekName}";
    } else if (Shared().validateDates(_ttFirstDate, nextWeekStartDate) &&
        Shared().validateDates(
            _ttLastDate, nextWeekStartDate.add(Duration(days: 6)))) {
      _ttAlias = "Next Week\n${currentTT.weekName}";
    } else {
      _ttAlias = currentTT.weekName;
    }
  }
}

//Shared Resources
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
