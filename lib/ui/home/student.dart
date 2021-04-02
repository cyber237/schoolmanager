import 'package:flutter/material.dart';
import '../timeTable/student/board.dart';
import '../attendance/student/board.dart';
import '../calender/board.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../logic/student/states/timetable.dart';
import '../../logic/student/services/timetable/connection.dart';

import '../../globalSettings.dart';
import '../../logic/shared/services/network_connection/networkConnectivity.dart';

class StudentHome extends StatefulWidget {
  StudentHome({Key key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  SnackBar serverError;
  NetworkConnectivity netConnect = new NetworkConnectivity();
  StreamSubscription netS;
  bool stretched = true;
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
    Future.delayed(Duration.zero, () async {
      await TimeTableConnection().getTimeTable();
    });

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
      color: Colors.grey.shade50,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            floating: true,
            pinned: true,
            backgroundColor: MAINAPPBARCOLOR.withOpacity(0.9),
            expandedHeight: 200,
            leading: new IconButton(
              icon: new Icon(Icons.menu, size: 30, color: MAINHEADTEXTCOLOR),
              onPressed: () => null,
            ),
            title: new Text("Home",
                style: new TextStyle(color: MAINHEADTEXTCOLOR, fontSize: 25)),
            flexibleSpace: FlexibleSpaceBar(),
          ),
          new SliverList(
            delegate: SliverChildListDelegate([
              new ChangeNotifierProvider(
                  builder: (context) => TimeTableDB(),
                  child: TimeTableBoard(
                    homeNetworkSubscription: netS,
                  )),
              CalenderBoard(),
              AttendanceBoard()
            ]),
          )
        ],
      ),
    );
  }

  void _checkConnect(BuildContext context) async {
    await netConnect.checkOnlineStatus().then((value) {
      if (!value) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(serverError);
      }
      return null;
    });
  }
}
