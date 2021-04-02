import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../database/timetable.dart';
import '../../../db_models/timetable/timetable.dart';
import '../../../../shared/services/network_connection/settings.dart';
import '../../../../shared/database/user.dart';

List<TimeTable> tts = [];
UserDB user = new UserDB();

//"$server_url/getTT/?accountType=student&platform=mobile&level=SWE_L2&_id=stud-8kckhkwr6ru";

class TimeTableConnection {
  static final TTDB db = new TTDB();
  List<TimeTable> timeTables = [];
  bool feedback = false;
  Future<void> getTimeTable() async {
    //Map reqData = await user.getTTRequestData();
    try {
      // await http
      //     .post("$server_url/getTT",
      //         headers: {"Content-Type": "application/json;charset=utf-8"},
      //         body: jsonEncode(<String, String>{
      //           'accountType': 'lecturer',
      //           'platform': 'mobile',
      //           '_id': 'L-kjjywgrv'
      //         }))
      await http
          .get(new Uri(
              scheme: "http",
              host: serverobj.host,
              port: serverobj.port,
              path: "/lecturer_tt/",
              queryParameters: {"id": "l-iuc19ee45"}))
          .timeout(Duration(milliseconds: 300), onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Time Table GET ERROR ::: $e");
      }).then((value) async {
        debugPrint("TT : $value");
        feedback = value != null;
        List ttDem = value == null ? [] : await json.decode(value.body);
        debugPrint("TT DEM: $ttDem");
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
