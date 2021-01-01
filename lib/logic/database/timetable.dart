import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../../data_in_memory/data_ui.dart';
import 'package:hive/hive.dart';
import '../db_models/timetable/timetable.dart';

class TimeTableDefault {
  List timeTables = [];
  Future<void> getTimeTable() async {
    try {
      await http
          .get(
              "http://192.168.1.2:45000/getTT/?accountType=student&platform=mobile&level=SWE_L2&_id=stud-8kckhkwr6ru")
          .timeout(Duration(seconds: 2), onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Time Table GET ERROR ::: $e");
      }).then((value) async {
        timeTables = value == null ? <Map>[] : await json.decode(value.body);
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

    if (!(b.length < 1)) {
      for (TimeTable item in b.values) {
        timeTables.add({"cells": item.cells, "week": item.weekInfo});
      }
    }
  }

  void storeTimeTable(List tts) async {
    Map tt = tts.last;
    var b = await Hive.openBox("timetable");
    int bLength = b.length - 1;
    TimeTable oldTT = bLength < 1 ? null : b.getAt(b.length - 1);
    TimeTable newTT = new TimeTable(cells: tt["cells"], weekInfo: tt["week"]);
    if (bLength >= 1) {
      if (oldTT.weekInfo["firstDay"] == newTT.weekInfo["firstDay"]) {
        b.deleteAt(b.length - 1);
        newTT.prevVersion = oldTT;
        b.add(newTT);
      } else {
        b.deleteAt(0);
        b.add(newTT);
      }
    } else {
      List<TimeTable> g = [];
      for (Map t in tts) {
        g.add(TimeTable(cells: t["cells"], weekInfo: t["week"]));
      }
      await b.addAll(g);
    }
  }
}

class TimeTableDB extends TimeTableDefault with ChangeNotifier {
  void getTT() async {
    await getTimeTable();
    debugPrint("Notifying Listeners ::: Listeners? $hasListeners");
    notifyListeners();
  }
}
