import '../../../../shared/services/network_connection/connectivity_status.dart';
import 'package:flutter/material.dart';
import '../../../states/timetable/schedule.dart';
import 'package:provider/provider.dart';

class NetworkConnectivityFeedBack {
  void _networkFeedback(ConnectivityStatus e, BuildContext context,
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
    Scaffold.of(context).removeCurrentSnackBar();
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
    var uiUpdater = Provider.of<TimeTableDB>(context);
    bool prevFeedBack = uiUpdater.feedback;

    Future.delayed(Duration(milliseconds: 100), () async {
      try {
        try {
          uiUpdater.getTT();
          if (!(uiUpdater.feedback == prevFeedBack)) {
            if (uiUpdater.feedback) {
              _networkFeedback(ConnectivityStatus.Cellular, context,
                  message: message);
            } else {
              _networkFeedback(ConnectivityStatus.Offline, context,
                  message: message);
            }
          }
        } catch (e) {
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(message);
        }
      } catch (e) {
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(message);
      }
    });
  }
}
