import 'package:flutter/material.dart';
import 'globalSettings.dart';
import 'ui/home/main.dart';
import 'ui/course/main.dart';
import 'ui/chat/main.dart';
import 'ui/activity/main.dart';
import 'logic/database/init.dart';
import 'ui/launch/login/main.dart';

void main() async {
  registerAllAdapters();
  runApp(new MaterialApp(home: new SafeArea(child: MainApp())));
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  //int networkChecks = 0;
  final Map bottomNavs = {
    "home": {"active": Icons.home_filled, "unselected": Icons.home_outlined},
    "activity": {
      "unselected": Icons.notifications_outlined,
      "active": Icons.notifications_active,
    },
    "chat": {"unselected": Icons.chat_outlined, "active": Icons.chat},
    "course": {"active": Icons.book_online, "unselected": Icons.book_outlined}
  };
  String head = "HOME";
  int current = 0;
  dynamic page = new Home();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      extendBodyBehindAppBar: true,
      backgroundColor: MAINAPPBARCOLOR,
      body: page,
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          selectedItemColor: MAINHEADTEXTCOLOR,
          unselectedItemColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
          selectedLabelStyle: new TextStyle(
              color: MAINHEADTEXTCOLOR,
              fontSize: 12,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: new TextStyle(
              color: MAINHEADTEXTCOLOR.withOpacity(0.8), fontSize: 11),
          //selectedFontSize: 15,
          //fixedColor: MAINHEADTEXTCOLOR,
          backgroundColor: MAINHEADTEXTCOLOR,
          currentIndex: current,
          items: bottomNavs.keys
              .map((e) => BottomNavigationBarItem(
                    icon: new IconButton(
                      icon: new Icon(
                        bottomNavs.keys.toList().indexOf(e) == current
                            ? bottomNavs[e]["active"]
                            : bottomNavs[e]["unselected"],
                        color: MAINHEADTEXTCOLOR,
                      ),
                      onPressed: () {
                        setState(() {
                          current = bottomNavs.keys.toList().indexOf(e);
                          head = e.toString().toUpperCase();
                        });
                        _navigate(e);
                      },
                    ),
                    label: e.toString().toUpperCase(),
                  ))
              .toList()),
    );
  }

  void _navigate(String pageName) {
    switch (pageName.toLowerCase()) {
      case "home":
        setState(() => page = Home());
        break;
      case "chat":
        setState(() => page = Chat());
        break;
      case "activity":
        setState(() => page = Activity());
        break;
      case "course":
        setState(() => page = Course());
        break;
    }
  }
}
