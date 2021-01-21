import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import '../../../globalSettings.dart';
import 'course_page.dart';

class OverallAttendance extends StatelessWidget {
  const OverallAttendance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [head(context), new AttendanceChart()],
      ),
    );
  }

  Widget head(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: _screenwidth * 0.9,
        child: new Text(
          "Overall Attendance",
          style: new TextStyle(
              fontSize: 25,
              color: MAINHEADTEXTCOLOR,
              fontWeight: FontWeight.w500),
        ));
  }
}

class AttendanceChart extends StatelessWidget {
  AttendanceChart({this.large = true});
  final bool large;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    final double _boxWidth =
        MediaQuery.of(context).size.width * (large ? 0.95 : 0.9);
    return new Card(
        elevation: large ? 5 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: new Container(
            width: _boxWidth,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: large ? Colors.grey.shade100 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(30)),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [chart(context), legends()],
            )));
  }

  Widget chart(BuildContext context) {
    final List values = load(context);
    final String _holeText = "  ${values[2]}  %\nAttended";
    final double chartWidth =
        MediaQuery.of(context).size.width * (large ? 0.6 : 0.4);
    return new AnimatedCircularChart(
      key: _chartKey,
      holeRadius: 25,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry([
          CircularSegmentEntry(values[2].toDouble(), Colors.green.shade700,
              rankKey: 'Attended'),
          CircularSegmentEntry(100, Colors.redAccent, rankKey: 'Skipped')
        ], rankKey: 'schedule')
      ],
      chartType: CircularChartType.Radial,
      duration: Duration(milliseconds: 800),
      percentageValues: true,
      startAngle: 360.0,
      holeLabel: _holeText,
      labelStyle:
          new TextStyle(fontSize: large ? 17 : 13, color: Colors.grey.shade800),
      //edgeStyle: SegmentEdgeStyle.round,
      size: Size(chartWidth, large ? 200 : 120),
    );
  }

  Widget legends() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shared().legend(color: Colors.green, label: 'Attended', size: 15),
          Shared().legend(color: Colors.redAccent, label: 'Skipped', size: 15)
        ],
      ),
    );
  }

  List load(BuildContext context) {
    int _attended = 160;
    int _total = 200;
    double _percentAttended = 0;
    List<CircularStackEntry> data;

    _percentAttended = (_attended * 100) / _total;

    data = <CircularStackEntry>[
      new CircularStackEntry([
        CircularSegmentEntry(_percentAttended, Colors.greenAccent,
            rankKey: 'Attended'),
        CircularSegmentEntry(100 - _percentAttended, Colors.redAccent,
            rankKey: 'Total')
      ], rankKey: 'schedule')
    ];
    try {
      _chartKey.currentState.updateData(data);
    } catch (e) {
      debugPrint("EXCEPTION IN Attendance CHART ::: $e");
    }

    return [_total, _attended, _percentAttended];
  }
}

class DashBoard extends StatelessWidget {
  const DashBoard({this.width, this.large = true});
  final double width;
  final bool large;
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final Color _borderColor = Colors.grey.shade400;
    return Container(
      width: width ?? _screenWidth * 0.95,
      padding: EdgeInsets.symmetric(vertical: large ? 20 : 10),
      margin: EdgeInsets.symmetric(vertical: large ? 20 : 10),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: _borderColor),
          borderRadius: new BorderRadius.circular(40)),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          field("200", "Total"),
          new Container(
              height: large ? 60 : 30,
              child: VerticalDivider(
                color: _borderColor,
                thickness: 1.5,
              )),
          field("160", "Attended"),
          new Container(
              height: large ? 60 : 30,
              child: VerticalDivider(
                color: _borderColor,
                thickness: 1.5,
              )),
          field("40", "Skipped"),
        ],
      ),
    );
  }

  Widget field(String head, String subHead) {
    return new Container(
      child: new Column(
        children: [
          new Text(
            head,
            style: new TextStyle(
                fontSize: large ? 23 : 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800),
          ),
          new Text(subHead,
              style: new TextStyle(
                  fontSize: large ? 17 : 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600))
        ],
      ),
    );
  }
}

class CourseBoard extends StatelessWidget {
  const CourseBoard({Key key, @required this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return Container(
        width: _screenwidth * 0.95,
        constraints: BoxConstraints(minHeight: 100),
        child: new InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => new StudentCourse(
                    title: data["course"],
                  ))),
          child: new Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: new Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                  ),
                  child: new Column(
                    children: [
                      head(context),
                      progressBar(context),
                      diagnostics()
                    ],
                  ))),
        ));
  }

  Widget head(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
      width: _screenwidth * 0.85,
      child: new Text(
        data["course"],
        style: new TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade700),
      ),
    );
  }

  Widget progressBar(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    final double _percentAttended = (data["attended"] * 100) / data["total"];
    final Color loaderColor =
        _percentAttended < 60 ? Colors.redAccent : Colors.green;
    return new Container(
      width: _screenwidth * 0.95,
      height: 30,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Container(
              width: _screenwidth * 0.7,
              height: 7,
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10)),
              child: new LinearProgressIndicator(
                backgroundColor: Colors.grey.shade400,
                value: _percentAttended / 100,
                valueColor: AlwaysStoppedAnimation(loaderColor),
              )),
          new Text("${_percentAttended.toStringAsFixed(2)}%",
              style: new TextStyle(color: loaderColor))
        ],
      ),
    );
  }

  Widget diagnostics() {
    final TextStyle highlighted = new TextStyle(
        color: Colors.grey.shade800, fontSize: 17, fontWeight: FontWeight.w500);
    final TextStyle norm = new TextStyle(
        color: Colors.grey.shade400, fontSize: 15, fontWeight: FontWeight.w400);
    return new Container(
      child: new Text.rich(
          TextSpan(text: "${data["attended"]}", style: highlighted, children: [
        TextSpan(text: " out of ", style: norm),
        TextSpan(text: "${data["total"]}", style: highlighted),
        TextSpan(text: " classes attended", style: norm),
      ])),
    );
  }
}

class CoursesDiagnostics extends StatelessWidget {
  final List<Map> _testData = [
    {"course": "Mathematics II", "attended": 47, "total": 54},
    {"course": "Physics I", "attended": 27, "total": 32},
    {"course": "C++ OOP", "attended": 14, "total": 40},
    {"course": "Python Fundamentals", "attended": 28, "total": 40},
    {"course": "OOP Javascript", "attended": 23, "total": 32},
  ];
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: [_head(context), _courses()],
      ),
    );
  }

  Widget _head(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: _screenwidth * 0.9,
        child: new Text(
          "All Courses",
          style: new TextStyle(
              fontSize: 25,
              color: MAINHEADTEXTCOLOR,
              fontWeight: FontWeight.w500),
        ));
  }

  Widget _courses() {
    return new Container(
      child: new Column(
        children: _testData.map((e) => CourseBoard(data: e)).toList(),
      ),
    );
  }
}

class ClassStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [head(context), new CourseChart(), new ClassStatSub()],
      ),
    );
  }

  Widget head(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: _screenwidth * 0.9,
        child: new Text(
          "Classes",
          style: new TextStyle(
              fontSize: 30,
              color: MAINHEADTEXTCOLOR,
              fontWeight: FontWeight.w500),
        ));
  }
}

class ClassStatSub extends StatelessWidget {
  final Map<String, int> data = {
    "total": 36,
    "Attendance conducted": 20,
    "skipped": 4,
    "attended": 16,
    "remaining": 16,
  };
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    final Widget fieldDivider = new Divider(
      endIndent: 40,
      indent: 40,
    );
    for (String key in data.keys.toList()) {
      data.keys.toList().indexOf(key) > 0
          ? children.addAll([fieldDivider, displayer(key, data[key])])
          : children.add(displayer(key, data[key]));
    }

    final double _boxWidth = MediaQuery.of(context).size.width * (0.95);
    return new Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: new Container(
            width: _boxWidth,
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30)),
            child: new Column(
              children: children,
            )));
  }

  Widget displayer(String head, int stat) {
    final TextStyle _headStyle = new TextStyle(
        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey.shade700);
    final TextStyle _statStyle = new TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey.shade50);
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Container(
                width: 120,
                child: new Text(
                  head.replaceRange(0, 1, head[0].toUpperCase()),
                  style: _headStyle,
                )),
            new Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                decoration: new BoxDecoration(
                    color: MAINHEADTEXTCOLOR.withOpacity(0.8),
                    borderRadius: new BorderRadius.circular(10)),
                child: new Text(
                  "${stat.toString().length > 1 ? stat : "0" + stat.toString()}",
                  style: _statStyle,
                ))
          ],
        ));
  }
}

class CourseChart extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    final double _boxWidth = MediaQuery.of(context).size.width * (0.95);
    return new Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: new Container(
            width: _boxWidth,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30)),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [chart(context), legends()],
            )));
  }

  Widget chart(BuildContext context) {
    final List values = load(context);
    final String _holeText = "  ${values[2]}  %\nAttended";
    final double chartWidth = MediaQuery.of(context).size.width * (0.6);
    return new AnimatedCircularChart(
      key: _chartKey,
      holeRadius: 25,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry([
          CircularSegmentEntry(values[2].toDouble(), Colors.green.shade700,
              rankKey: 'Attended'),
          CircularSegmentEntry(100, Colors.redAccent, rankKey: 'Skipped')
        ], rankKey: 'schedule')
      ],
      chartType: CircularChartType.Radial,
      duration: Duration(milliseconds: 800),
      percentageValues: true,
      startAngle: 360.0,
      holeLabel: _holeText,
      labelStyle: new TextStyle(fontSize: 17, color: Colors.grey.shade800),
      //edgeStyle: SegmentEdgeStyle.round,
      size: Size(chartWidth, 200),
    );
  }

  Widget legends() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shared().legend(color: Colors.green, label: 'Attended', size: 15),
          Shared().legend(color: Colors.redAccent, label: 'Skipped', size: 15)
        ],
      ),
    );
  }

  List load(BuildContext context) {
    int _attended = 16;
    int _total = 20;
    double _percentAttended = 0;
    List<CircularStackEntry> data;

    _percentAttended = (_attended * 100) / _total;

    data = <CircularStackEntry>[
      new CircularStackEntry([
        CircularSegmentEntry(_percentAttended, Colors.greenAccent,
            rankKey: 'Attended'),
        CircularSegmentEntry(100 - _percentAttended, Colors.redAccent,
            rankKey: 'Total')
      ], rankKey: 'schedule')
    ];
    try {
      _chartKey.currentState.updateData(data);
    } catch (e) {
      debugPrint("EXCEPTION IN Attendance CHART ::: $e");
    }

    return [_total, _attended, _percentAttended];
  }
}

class Shared {
  Widget legend({Color color, String label, double size}) {
    return new Container(
        padding: EdgeInsets.all(5),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: new Container(
                color: color,
                width: size,
                height: size,
              ),
            ),
            new Padding(
                padding: new EdgeInsets.only(left: 5),
                child: new Text(label.toUpperCase(),
                    style: new TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w600)))
          ],
        ));
  }
}
