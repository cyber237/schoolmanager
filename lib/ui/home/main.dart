import 'package:flutter/material.dart';
import '../timeTable/student_timetable/timeTableBoard.dart';
import 'curved_back.dart';
import '../calender/calenderBoard.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../logic/database/timetable.dart';
import 'hallOfFame_board.dart';
import '../../globalSettings.dart';
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
      await TimeTableDefault().getTimeTable();
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
        child: new Stack(fit: StackFit.expand, children: [
          CurvedBack(),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                floating: true,
                pinned: true,
                backgroundColor: MAINAPPBARCOLOR.withOpacity(0.9),
                expandedHeight: 200,
                leading: new IconButton(
                  icon:
                      new Icon(Icons.menu, size: 30, color: MAINHEADTEXTCOLOR),
                  onPressed: () => null,
                ),
                title: new Text("Home",
                    style:
                        new TextStyle(color: MAINHEADTEXTCOLOR, fontSize: 25)),
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
                  HallFameBoard()
                ]),
              )
            ],
          ),
        ]));
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
