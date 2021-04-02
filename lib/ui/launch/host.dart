import 'dart:ui';
import '../../logic/shared/services/network_connection/settings.dart';
import '../../globalSettings.dart';
import '../../logic/shared/db_models/user/user.dart';
import '../../main.dart';
import 'login/main.dart';
import 'package:flutter/material.dart';

class Host extends StatelessWidget {
  Host({Key key, @required this.user}) : super(key: key);
  final User user;
  final TextEditingController _ip = new TextEditingController();
  final TextEditingController _port = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double _buttWidth = MediaQuery.of(context).size.width * 0.8;
    return new Scaffold(
        body: new Container(
      child: new Column(
        children: [
          new Expanded(
              flex: 2,
              child: new Center(
                child: new Text(
                  'HOST LOCATION',
                  style: new TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500),
                ),
              )),
          new Expanded(
            flex: 2,
            child: new Center(child: _form(context)),
          ),
          new Expanded(
            flex: 1,
            child: new Center(
                child: new Container(
              width: _buttWidth,
              height: 60,
              child: new ElevatedButton(
                // style: ButtonStyle(backgroundColor: MAINHEADTEXTCOLOR),
                onPressed: () {
                  serverobj =
                      new Uri(host: _ip.text, port: int.parse(_port.text));
                  dynamic _page = user != null
                      ? new MainApp(
                          user: user,
                        )
                      : new LoginPage();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => _page));
                },
                child: new Text(
                  "Save",
                  style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            )),
          )
        ],
      ),
    ));
  }

  Widget _form(BuildContext context) {
    final double _inputWidth = MediaQuery.of(context).size.width * 0.8;
    return new Container(
      child: new Column(
        children: [
          new Container(
            width: _inputWidth,
            height: 70,
            child: new TextField(
              controller: _ip,
              decoration: new InputDecoration(labelText: "Host IP"),
            ),
          ),
          new Container(
            width: _inputWidth,
            height: 70,
            child: new TextField(
              controller: _port,
              decoration: new InputDecoration(labelText: "Port"),
            ),
          )
        ],
      ),
    );
  }
}
