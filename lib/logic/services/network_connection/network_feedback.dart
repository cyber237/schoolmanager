import 'networkConnectivity.dart';
import 'connectivity_status.dart';
import 'package:flutter/material.dart';
import '../../database/timetable.dart';
import 'package:provider/provider.dart';

void networkFeedback(ConnectivityStatus e, BuildContext context,
    {SnackBar message}) {
  final Duration duration = new Duration(seconds: 3);
  final SnackBar offline = new SnackBar(
    content: new Text("Offline! Can't connect to server"),
    duration: duration,
    action: new SnackBarAction(
        label: "Retry", onPressed: () => retryTimeTable(context, message)),
  );
  final SnackBar online = new SnackBar(
    content: new Text("Online"),
    duration: duration,
  );
  switch (e) {
    case ConnectivityStatus.Cellular:
      Scaffold.of(context).showSnackBar(online);
      break;
    case ConnectivityStatus.Wifi:
      Scaffold.of(context).showSnackBar(online);
      break;
    case ConnectivityStatus.Offline:
      Scaffold.of(context).showSnackBar(offline);
      break;
    default:
      Scaffold.of(context).showSnackBar(offline);
  }
}

void retryTimeTable(BuildContext context, SnackBar message) {
  NetworkConnectivity netConnect = new NetworkConnectivity();
  var uiUpdater = Provider.of<TimeTableDB>(context);

  Future.delayed(Duration(milliseconds: 500), () async {
    try {
      await netConnect.checkOnlineStatus().then((value) async {
        if (value) {
          try {
            networkFeedback(ConnectivityStatus.Cellular, context,
                message: message);
            uiUpdater.getTT();
          } catch (e) {
            Scaffold.of(context).showSnackBar(message);
          }
        } else {
          networkFeedback(ConnectivityStatus.Offline, context,
              message: message);
        }
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(message);
    }
  });
}
