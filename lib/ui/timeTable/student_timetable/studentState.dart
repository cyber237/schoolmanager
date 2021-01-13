import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'widgets.dart';
import '../../../logic/database/timetable.dart';
import '../../../logic/db_models/timetable/timetable.dart';

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
