import 'package:flutter/material.dart';
import 'package:schoolmanager/globalSettings.dart';
import '../../../logic/shared/db_models/user/type.dart';
import '../../../logic/shared/db_models/user/user.dart';

class HomeDashBoard extends StatelessWidget {
  HomeDashBoard({Key key, @required this.user}) : super(key: key);
  final User user;
  final TextStyle t = new TextStyle(fontSize: 20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [_welcome(), _identification(), _belowLecturer()]),
    );
  }

  Widget _welcome() {
    return new Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                "Welcome back !",
                style: new TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: MAINHEADTEXTCOLOR.withOpacity(0.9)),
              ),
              new Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 60, top: 5),
                  child: new Text(
                    "${this.user.firstName.toUpperCase()}",
                    style: new TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
                  ))
            ]));
  }

  Widget _identification() {
    return new Container(
      margin: EdgeInsets.only(bottom: 20, top: 10),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                  border: new Border.all(
                      color: Colors.green.withOpacity(0.2), width: 1),
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 10,
                  child: new CircleAvatar(
                    maxRadius: 52,
                    minRadius: 40,
                    backgroundColor: Colors.white70,
                    child: new Container(
                      child: new Center(
                        child: new Text(
                          "${this.user.firstName[0]}${this.user.lastName[0]}",
                          style: new TextStyle(
                              fontSize: 30,
                              color: MAINHEADTEXTCOLOR.withOpacity(0.9)),
                        ),
                      ),
                    ),
                  ))),
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _record("Matricule", "${this.user.id}", MAINHEADTEXTCOLOR),
                _record(
                    "Account Type",
                    this.user.accountType == UserType.Lecturer
                        ? "Lecturer"
                        : "Student",
                    Colors.green.shade800),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _record(String head, String detail, Color recordColor) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: new Row(
          children: [
            new Text(
              head + ":   ",
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: recordColor),
            ),
            new Text(detail,
                style: new TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: MAINHEADTEXTCOLOR))
          ],
        ));
  }

  Widget _belowStud() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          new Row(
            children: [
              _record("Speciality: ", user.studentInfo.speciality,
                  MAINHEADTEXTCOLOR)
            ],
          ),
          new Row(
            children: [
              _record("Level: ", user.studentInfo.level, Colors.green.shade900)
            ],
          ),
        ],
      ),
    );
  }

  Widget _belowLecturer() {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: new Column(
        children: [
          _option("View courses you tutor", MAINHEADTEXTCOLOR),
          _option("View important events", Colors.green.shade900)
        ],
      ),
    );
  }

  Widget _option(String text, Color buttColor) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          new Text(
            text,
            style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          new ElevatedButton(
            child: new Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () => null,
            style: new ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => new Size(50, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(),
                    borderRadius: BorderRadius.circular(10))),
                elevation: MaterialStateProperty.all(10.0),
                backgroundColor: MaterialStateProperty.all(buttColor)),
          )
        ],
      ),
    );
  }
}
