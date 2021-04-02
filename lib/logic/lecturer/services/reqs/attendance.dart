import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:schoolmanager/logic/lecturer/database/attendance.dart';
import 'package:schoolmanager/logic/shared/db_models/user/user.dart';
import '../../../shared/services/network_connection/settings.dart';
import 'package:http/http.dart' as http;
import '../../../shared/database/user.dart';
import '../../../shared/services/network_connection/networkConnectivity.dart';

class AttendanceConnection {
  Uri url = serverobj;
  UserDB userdb = new UserDB();
  AttendanceLecturerDB attLecturer = new AttendanceLecturerDB();
  User user;
  NetworkConnectivity netc = new NetworkConnectivity();
  Future<void> getCourses() async {
    bool online = await netc.checkOnlineStatus();
    List data;
    if (online) {
      Future.delayed(Duration.zero, () async {
        user = await userdb.getUser().then((value) {
          url = new Uri(
              scheme: "http",
              host: serverobj.host,
              port: serverobj.port,
              path: "/courses/",
              queryParameters: {"lecturer": "l-iuc19ee45"});
          return value;
        });
      }).whenComplete(() async {
        try {
          await http
              .get(url)
              .timeout(Duration(milliseconds: 300))
              .catchError((e) {
            debugPrint("GET COURSE ERROR::: $e");
            return null;
          }).then((value) async {
            data = value == null
                ? null
                : value.body == null
                    ? null
                    : await json.decode(value.body);
            debugPrint("${data ?? 'Empty'}");
            if (data != null) {
              await attLecturer.storeCourses(data);
            }
          }, onError: (e) {
            debugPrint("GETT aTT ERROR::");
            return null;
          });
        } on SocketException {
          debugPrint("Socket Exception in get Course::::");
        }
      });
    }
  }
}
