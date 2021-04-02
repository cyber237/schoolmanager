import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolmanager/ui/home/widgets/dashBoard.dart';
import '../../logic/lecturer/states/timetable/schedule.dart';
import '../../globalSettings.dart';
import '../../logic/shared/services/network_connection/networkConnectivity.dart';
import '../attendance/lecturer/board.dart';
import '../calender/board.dart';
import '../timetable/lecturer/board.dart';
import 'package:schoolmanager/logic/shared/db_models/user/user.dart';

class LecturerHome extends StatefulWidget {
  LecturerHome({Key key, @required this.lecturer}) : super(key: key);
  final User lecturer;

  @override
  _LecturerHomeState createState() => _LecturerHomeState();
}

class _LecturerHomeState extends State<LecturerHome> {
  SnackBar serverError;
  NetworkConnectivity netConnect = new NetworkConnectivity();
  StreamSubscription netS;
  bool stretched = true;
  final ScrollController stretchControll = new ScrollController();
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
    stretchControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.grey.shade50,
      child: new NotificationListener<ScrollUpdateNotification>(
          onNotification: (not) {
            if (stretchControll.position.pixels < 400) {
              if (!stretched) {
                setState(() => stretched = true);
              }
            } else {
              if (stretched) {
                setState(() => stretched = false);
              }
            }
            return true;
          },
          child: new CustomScrollView(
            controller: stretchControll,
            slivers: [
              SliverAppBar(
                centerTitle: !stretched,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                //floating: true,
                pinned: true,
                backgroundColor: Colors.white.withOpacity(stretched ? 0 : 0.9),
                expandedHeight: 450,
                leading: new IconButton(
                  icon:
                      new Icon(Icons.menu, size: 45, color: MAINHEADTEXTCOLOR),
                  onPressed: () => null,
                ),
                title: new Text(stretched ? "" : "Home",
                    style:
                        new TextStyle(color: MAINHEADTEXTCOLOR, fontSize: 25)),
                flexibleSpace: FlexibleSpaceBar(
                  background: HomeDashBoard(user: widget.lecturer),
                  centerTitle: true,
                ),
                onStretchTrigger: () async {
                  debugPrint("Stretched");
                  return setState(() => stretched = !stretched);
                },
              ),
              new SliverList(
                delegate: SliverChildListDelegate([
                  new ChangeNotifierProvider(
                      builder: (context) => new TimeTableDB(),
                      child: new TimeTableBoard()),
                  new CalenderBoard(),
                  new AttendanceBoard(),
                ]),
              )
            ],
          )),
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
