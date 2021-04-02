import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:schoolmanager/logic/shared/db_models/user/user.dart';
import 'globalSettings.dart';
import 'ui/home/lecturer.dart';
import 'ui/home/student.dart';
import 'ui/course/main.dart';
import 'ui/chat/main.dart';
import 'ui/activity/main.dart';
import 'logic/lecturer/database/init.dart';
import 'logic/shared/db_models/user/type.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ui/launch/host.dart';
import 'logic/shared/database/user.dart';
import 'logic/shared/database/init.dart';

void main() async {
  await Hive.initFlutter();
  registerSharedAdapters();
  User user = await UserDB().getUser();
  // TODO: uncommect and remove join usertype registration
  // if (accountType != null) {
  //   if (accountType == UserType.Lecturer) {
  //     await registerLecturerAdapters();
  //   } else {
  //     await registerStudentAdapters();
  //   }
  // }
  await registerLecturerAdapters();
  runApp(new MaterialApp(
    color: Colors.white,
    theme: new ThemeData(highlightColor: MAINHEADTEXTCOLOR),
    home: new SafeArea(
      child: new Host(user: user),
    ),
  ));

  // runApp(new MaterialApp(
  //     home: new SafeArea(
  //         child: accountType != null
  //             ? new MainApp(
  //                 accountType: accountType,
  //               )
  //             : new LoginPage())));
}

class MainApp extends StatefulWidget {
  MainApp({@required this.user});
  final User user;
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
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
  dynamic page;

  @override
  void initState() {
    page = widget.user.accountType == UserType.Lecturer
        ? new LecturerHome(
            lecturer: widget.user,
          )
        : new StudentHome();

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
          elevation: 10,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          selectedItemColor: MAINHEADTEXTCOLOR,
          unselectedItemColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
          selectedLabelStyle: new TextStyle(
              color: MAINHEADTEXTCOLOR,
              fontSize: 12,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: new TextStyle(
              color: MAINHEADTEXTCOLOR.withOpacity(0.8), fontSize: 11),
          backgroundColor: Colors.white,
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
        setState(() => page = widget.user.accountType == UserType.Lecturer
            ? new LecturerHome(lecturer: widget.user)
            : new StudentHome());
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
