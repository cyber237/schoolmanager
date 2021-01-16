import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'status.dart';

class Auth {
  Status status;

  Future<void> login(String id) async {
    const String url = "http://192.168.1.2:45000/login";
    const Map<String, String> header = {
      "Content-Type": "application/json;charset=utf-8"
    };
    final String body =
        jsonEncode(<String, String>{'platform': 'mobile', '_id': 'L-kjjywgrv'});

    try {
      await http
          .post(url, headers: header, body: body)
          .timeout(Duration(seconds: 2), onTimeout: () async {
        return null;
      }).catchError((e) {
        debugPrint("Authentication ERROR ::: $e");
      }).then((value) async {
        status =
            value.statusCode == 201 ? Status.Succesfull : Status.Unsuccesfull;
        return value;
      });
    } on SocketException {
      debugPrint("Authentication Socket exception");
    }
  }
}
