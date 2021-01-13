import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../../data_in_memory/data_ui.dart';
import 'package:hive/hive.dart';
import '../db_models/timetable/timetable.dart';

List<TimeTable> tts = [];
final String studentUrl =
    "http://192.168.1.2:45000/getTT/?accountType=student&platform=mobile&level=SWE_L2&_id=stud-8kckhkwr6ru";

class TimeTableDefault {
  List<TimeTable> timeTables = [];
  bool feedback = false;
  Future<void> getTimeTable() async {
    try {
      await http
          .post("http://192.168.1.2:45000/getTT",
              headers: {"Content-Type": "application/json;charset=utf-8"},
              body: jsonEncode(<String, String>{
                'accountType': 'lecturer',
                'platform': 'mobile',
                '_id': 'L-kjjywgrv'
              }))
          .timeout(Duration(seconds: 2), onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Time Table GET ERROR ::: $e");
      }).then((value) async {
        debugPrint("TT : $value");
        feedback = value != null;
        timeTables = value == null ? [] : await packData(value.body);
        if (timeTables.toList().length >= 1) {
          storeTimeTable(timeTables);
        }
        debugPrint("$timeTables");

        return value;
      });
    } on SocketException {
      debugPrint("Time Table GET Socket exception");
    }

    await loadTimeTableLocal();
  }

  Future<void> loadTimeTableLocal() async {
    var b = await Hive.openBox("timetable");
    debugPrint("${b.length} timetables in box");
    timeTables = b.values.map((e) => e as TimeTable).toList();
    tts = timeTables;
  }

  void storeTimeTable(List tts) async {
    TimeTable tt = tts.last;
    var b = await Hive.openBox("timetable");
    int bLength = b.length - 1;
    TimeTable oldTT = bLength < 1 ? null : b.getAt(b.length - 1);
    if (bLength >= 1) {
      if (oldTT.weekInfo["firstDay"] == tt.weekInfo["firstDay"]) {
        tt.prevVersion = oldTT;
        b.add(tt);
        oldTT.delete();
      } else {
        b
          ..deleteAt(0)
          ..add(tt);
      }
    } else {
      List<TimeTable> g = [];
      g.addAll(tts as List<TimeTable>);
      await b.addAll(g);
    }
  }

  Future<List<TimeTable>> packData(String jsonPayLoad) async {
    List<TimeTable> ttList = [];
    List ttJsonList = await json.decode(jsonPayLoad);
    ttList.addAll(ttJsonList
        .map((tt) => new TimeTable(
            periods: getPeriods(tt["periods"]), weekInfo: tt["week"]))
        .toList());
    return ttList;
  }

  List<List<Period>> getPeriods(List periods) {
    List<List<Period>> periodsList = [];
    for (List pp in periods) {
      List<Period> tempList = [];
      for (Map pe in pp) {
        tempList.add(Period(
            courseName: pe["courseName"],
            courseInfo: pe["courseInfo"],
            lecturerName: pe["lecturerName"],
            lecturerId: pe["lecturerId"],
            start: pe["start"],
            stop: pe["stop"],
            state: pe["state"],
            level: pe["level"],
            venue: pe["venue"],
            data: pe));
      }
      periodsList.add(tempList);
    }
    return periodsList;
  }
}

class TimeTableDB extends TimeTableDefault with ChangeNotifier {
  Future<void> getTT() async {
    await getTimeTable();
    debugPrint("Notifying Listeners ::: Listeners? $hasListeners");
    notifyListeners();
  }
}
