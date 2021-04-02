import 'package:flutter/material.dart';
import '../../../../globalSettings.dart';

class AvailTable extends StatefulWidget {
  AvailTable({@required this.mutable});
  final bool mutable;
  @override
  State<StatefulWidget> createState() => new _AvailTableState();
}

class _AvailTableState extends State<AvailTable> {
  final SysDefaults sysDef = new SysDefaults();
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        //color: Colors.blue,

        child: new Column(children: [
          new Container(
              height: 600.0,
              child: new Card(
                  elevation: 10,
                  child: new Scrollbar(
                      isAlwaysShown: true,
                      thickness: 4.0,
                      radius: new Radius.circular(10),
                      controller: controller,
                      child: new ListView(
                          primary: true,
                          shrinkWrap: true,
                          reverse: true,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.horizontal,
                          children: [
                            new Table(
                              border: TableBorder.symmetric(
                                  inside: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                  outside:
                                      BorderSide(color: Colors.grey, width: 1)),
                              defaultColumnWidth: FixedColumnWidth(100.0),
                              columnWidths: {0: FixedColumnWidth(150.0)},
                              children: _generateData(sysDef),
                            ),
                          ])))),
          widget.mutable
              ? new Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: new ElevatedButton(
                    style: new ButtonStyle(
                        textStyle: MaterialStateProperty.resolveWith((state) =>
                            new TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600)),
                        elevation:
                            MaterialStateProperty.resolveWith((state) => 10.0),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (state) => MAINHEADTEXTCOLOR),
                        minimumSize: MaterialStateProperty.resolveWith(
                            (state) => Size(150, 50))),
                    child: new Text("Edit"),
                    onPressed: () => null,
                  ))
              : new SizedBox()
        ]));
  }

  List<TableRow> _generateData(SysDefaults sysdef) {
    final TextStyle _headStyle =
        new TextStyle(fontSize: 20, color: Colors.white);
    List<Widget> _headWidgets = [
      new Container(
        height: 60,
        child: new Center(
            child: new Text(
          "Period",
          style: _headStyle,
        )),
        color: MAINHEADTEXTCOLOR,
      )
    ];
    _headWidgets.addAll(sysDef.weekDays
        .map((e) => new Container(
            height: 60,
            color: MAINHEADTEXTCOLOR,
            child: new Center(
                child: new Text(
              "${e.substring(0, 3).toUpperCase()}",
              style: _headStyle,
            ))))
        .toList());
    final TableRow _tableHead = new TableRow(children: _headWidgets);
    final List<TableRow> _children = [_tableHead];
    List<Widget> _temp;
    for (Map period in sysdef.periods) {
      //Adding period title
      _temp = [
        new Container(
            constraints: BoxConstraints(minHeight: 80, minWidth: 150),
            color: Colors.grey.shade300,
            child: new Center(
                child: new Text(
              "${period['start']} - ${period['stop']}",
              style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )))
      ];
      //Adding period data
      _temp.addAll(sysdef.weekDays
          .map((e) => new Container(
              constraints: BoxConstraints(minHeight: 80),
              child: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: new _ASwitch())))
          .toList());
      _children.add(new TableRow(children: _temp));
    }
    return _children;
  }
}

class _ASwitch extends StatefulWidget {
  _ASwitch({Key key}) : super(key: key);
  bool val;

  @override
  __ASwitchState createState() => __ASwitchState();
}

class __ASwitchState extends State<_ASwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Transform.scale(
      scale: 1.5,
      child: new Switch(
        value: _value,
        activeColor: Colors.green,
        inactiveTrackColor: Colors.red,
        onChanged: (newVal) => setState(() => _value = widget.val = newVal),
      ),
    ));
  }
}

class SysDefaults {
  final List<Map> periods = [
    {"start": "08:00", "stop": "09:50"},
    {"start": "10:10", "stop": "12:00"},
    {"start": "01:00", "stop": "02:50"},
    {"start": "03:10", "stop": "05:00"},
    {"start": "05:30", "stop": "19:30"},
    {"start": "20:00", "stop": "21:30"},
  ];
  final List<String> weekDays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];
  final List<Map> pauses = [
    {"name": "Morning pause", "index": 0},
    {"name": "Long pause", "index": 1},
    {"name": "Afternoon pause", "index": 2},
    {"name": "Closing", "index": 3},
    {"name": "Evening pause", "index": 4},
  ];
}
