import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../database/timetable.dart';
import '../../db_models/timetable/timetable.dart';
import '../../../shared/services/network_connection/settings.dart';

List<TimeTable> tts = [];
final String studentUrl =
    "$server_url/getTT/?accountType=student&platform=mobile&level=SWE_L2&_id=stud-8kckhkwr6ru";

class TimeTableConnection {
  static final TTDB db = new TTDB();
  List<TimeTable> timeTables = [];
  bool feedback = false;
  Future<void> getTimeTable() async {
    try {
      // await http
      //     .post("$server_url/getTT",
      //         headers: {"Content-Type": "application/json;charset=utf-8"},
      //         body: jsonEncode(<String, String>{
      //           'accountType': 'lecturer',
      //           'platform': 'mobile',
      //           '_id': 'L-kjjywgrv'
      //         }))
      await http.get("$server_url/getTT/").timeout(Duration(seconds: 2),
          onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Time Table GET ERROR ::: $e");
      }).then((value) async {
        debugPrint("TT : $value");
        feedback = value != null;
        List ttDem = value == null ? [] : await json.decode(value.body);
        if (ttDem.toList().length >= 1) {
          db.storeTimeTable(value.body);
        }

        return value;
      });
    } on SocketException {
      debugPrint("Time Table GET Socket exception");
    }

    timeTables = await db.loadTimeTableLocal();
    tts = timeTables;
    debugPrint("$timeTables");
  }
}
