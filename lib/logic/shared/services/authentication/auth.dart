import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'status.dart';
import '../network_connection/settings.dart';
import '../../database/user.dart';
import '../../db_models/user/type.dart';

class Auth {
  Status status;
  UserType acType;

  Future<void> login(String id, String password) async {
    final Uri url = new Uri(
        scheme: "http",
        host: serverobj.host,
        port: serverobj.port,
        path: "/login",
        queryParameters: {"id": id, "password": password});
    //Uri.dataFromString("$server_url/login/?id=$id&password=$password");
    //final String url = "$server_url/get_lecturer/?id=$id&password=$password";
    // const Map<String, String> header = {
    //   "Content-Type": "application/json;charset=utf-8"
    // };
    // final String body =
    //     jsonEncode(<String, String>{'platform': 'mobile', '_id': '$id'});

    try {
      await http.get(url)
          //.post(url, headers: header, body: body)
          .timeout(Duration(seconds: 2), onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Authentication ERROR ::: $e");
      }).then((value) async {
        status = value != null
            ? value.statusCode == 200 && value.body.isNotEmpty
                ? Status.Succesfull
                : Status.Unsuccesfull
            : Status.Unsuccesfull;
        if (status == Status.Succesfull) {
          var g = await json.decode(value.body);
          debugPrint("data :$g");
          await UserDB()
              .storeLoginData(json.decode(value.body) as Map, password);
          acType = await UserDB().checkUser();
        }
        return value;
      });
    } on SocketException {
      debugPrint("Authentication Socket exception");
    }
  }
}
