import 'package:flutter/material.dart';
import 'timeTableBoard.dart';
import 'curved_back.dart';
import 'calenderBoard.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../logic/database/timetable.dart';
//import '../../logic/services/network_connection/network_feedback.dart';
import '../../logic/services/network_connection/networkConnectivity.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SnackBar serverError;
  NetworkConnectivity netConnect = new NetworkConnectivity();
  StreamSubscription netS;
  @override
  void initState() {
    serverError = new SnackBar(
      content: new Text(
          "Can't connect to server at the moment.\nCheck internet connection and retry"),
      action: new SnackBarAction(
          label: "Retry",
          onPressed: (() {
            _checkConnect(context);
          })),
      duration: Duration(seconds: 4),
    );

    _checkConnect(context);
    netS = netConnect.connectionStatusController.stream.listen((event) {
      _checkConnect(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () async => await netS.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: new Stack(fit: StackFit.expand, children: [
          CurvedBack(),
          new ListView(
            padding: EdgeInsets.only(top: 100),
            children: [
              ChangeNotifierProvider(
                  builder: (context) => TimeTableDB(),
                  child: TimeTableBoard(
                    homeNetworkSubscription: netS,
                  )),
              CalenderBoard()
            ],
          ),
        ]));
  }

  void _checkConnect(BuildContext context) async {
    await netConnect.checkOnlineStatus().then((value) {
      if (!value) {
        Scaffold.of(context).showSnackBar(serverError);
      }
      return null;
    });
  }
}
