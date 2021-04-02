import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import '../db_models/timetable/timetable.dart';

class TTDB {
  void storeTimeTable(String payload) async {
    List<TimeTable> tts = await packData(payload);
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
      g.addAll(tts);
      await b.addAll(g);
    }
  }

  List<List<Period>> getPeriods(List periods) {
    List<List<Period>> periodsList = [];
    for (List pp in periods) {
      List<Period> tempList = [];
      for (Map pe in pp) {
        tempList.add(Period(
            courseName: pe["courseInfo"],
            courseInfo: pe["courseInfo"],
            start: pe["start"],
            stop: pe["stop"],
            state: pe["state"],
            group: pe["group"],
            venue: pe["venue"],
            data: pe));
      }
      periodsList.add(tempList);
    }
    return periodsList;
  }

  Future<List<TimeTable>> packData(String jsonPayLoad) async {
    List<TimeTable> ttList = [];
    List ttJsonList = await json.decode(jsonPayLoad);
    ttList.addAll(ttJsonList
        .map((tt) => new TimeTable(
            periods: getPeriods(json.decode(tt["periods"])),
            weekInfo: tt["week"]))
        .toList());
    return ttList;
  }

  Future<List<TimeTable>> loadTimeTableLocal() async {
    var b = await Hive.openBox("timetable");
    debugPrint("${b.length} timetables in box");
    final List<TimeTable> timeTables =
        b.values.map((e) => e as TimeTable).toList();
    return timeTables;
  }
}
