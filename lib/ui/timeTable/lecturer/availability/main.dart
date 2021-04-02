import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:schoolmanager/globalSettings.dart';
//import 'package:schoolmanager/globalSettings.dart';
import 'widget.dart';

class AvailTimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(children: [_head(), _otherOptions(), new _AvailTabs()]);
  }

  Widget _head() {
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: new Text(
          "AVAILABILITY\nSCHEDULE",
          style: new TextStyle(
              color: Colors.grey.shade700,
              fontSize: 30,
              height: 1.3,
              fontWeight: FontWeight.w700),
        ));
  }

  Widget _otherOptions() {
    return new Container(
      child: new Column(
        children: [
          _option("Edit next week availability"),
          _option("Edit next default availability"),
        ],
      ),
    );
  }

  Widget _option(String text) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                shape: MaterialStateProperty.resolveWith((states) =>
                    RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.circular(10))),
                elevation: MaterialStateProperty.resolveWith((states) => 10.0),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => MAINHEADTEXTCOLOR)),
          )
        ],
      ),
    );
  }
}

class _AvailTabs extends StatelessWidget {
  _AvailTabs({Key key}) : super(key: key);
  final Tab _current = new Tab(
    text: "Current week",
  );
  final Tab _next = new Tab(
    text: "Next week",
  );
  final Tab _default = new Tab(
    text: "Default week",
  );

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: new Container(
        constraints: new BoxConstraints(maxHeight: 800),
        child: new Scaffold(
            appBar: new TabBar(
              isScrollable: true,
              indicatorColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
              labelColor: MAINHEADTEXTCOLOR.withOpacity(0.8),
              unselectedLabelColor: MAINHEADTEXTCOLOR.withOpacity(0.5),
              labelStyle: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MAINHEADTEXTCOLOR),
              unselectedLabelStyle: new TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
              tabs: [_current, _next, _default],
            ),
            body: new TabBarView(
              children: [
                AvailTable(mutable: false),
                new AvailTable(
                  mutable: true,
                ),
                new AvailTable(
                  mutable: true,
                )
              ],
            )),
      ),
    );
  }
}
