import 'package:flutter/material.dart';
import 'widgets/curved_back.dart';
import '../attendance/lecturer/board.dart';
import '../calender/board.dart';
import 'dart:async';
import '../../globalSettings.dart';
import '../../logic/shared/services/network_connection/networkConnectivity.dart';

class LecturerHome extends StatefulWidget {
  LecturerHome({Key key}) : super(key: key);

  @override
  _LecturerHomeState createState() => _LecturerHomeState();
}

class _LecturerHomeState extends State<LecturerHome> {
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
                delegate: SliverChildListDelegate(
                    [CalenderBoard(), AttendanceBoard()]),
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
