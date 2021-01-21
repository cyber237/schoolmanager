import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../logic/states/timetable.dart';
import '../../../logic/db_models/timetable/timetable.dart';
import 'widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [PeriodsChart(), WeekSlides()]),
    );
  }
}

class PeriodsChart extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Row(
      mainAxisSize: MainAxisSize.min,
      children: [chart(context), legends()],
    ));
  }

  Widget chart(BuildContext context) {
    final List<int> values = load(context);
    final String _holeText = "${values[1]} / ${values[0]}";
    return new AnimatedCircularChart(
      key: _chartKey,
      holeRadius: 25,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry([
          CircularSegmentEntry(0, Colors.blue, rankKey: 'programmed'),
          CircularSegmentEntry(100, Colors.blueGrey.shade200, rankKey: 'total')
        ], rankKey: 'schedule')
      ],
      chartType: CircularChartType.Radial,
      duration: Duration(milliseconds: 400),
      percentageValues: true,
      startAngle: 90.0,
      holeLabel: _holeText,
      labelStyle: new TextStyle(fontSize: 17, color: Colors.grey.shade800),
      edgeStyle: SegmentEdgeStyle.round,
      size: Size(130, 130),
    );
  }

  Widget legends() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          legend(color: Colors.blue, label: 'programmed', size: 15),
          legend(color: Colors.blueGrey.shade200, label: 'free', size: 15)
        ],
      ),
    );
  }

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
                        fontSize: 15,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w600)))
          ],
        ));
  }

  List<int> load(BuildContext context) {
    List<List<Period>> periods;
    int _progged = 0;
    int _total = 0;
    double _percentProgged = 0;
    List<CircularStackEntry> data;
    var upStream = Provider.of<TimeTableNotifier>(context);
    try {
      periods = upStream.data.periods;
    } catch (e) {
      periods = [];
    }

    periods.forEach((day) {
      day.forEach((element) {
        _total += 1;
        if (element.courseInfo != "") {
          _progged += 1;
        }
      });
    });

    _percentProgged = ((_progged) * 100) / _total;

    data = <CircularStackEntry>[
      new CircularStackEntry([
        CircularSegmentEntry(_percentProgged, Colors.blue,
            rankKey: 'programmed'),
        CircularSegmentEntry(100 - _percentProgged, Colors.blueGrey.shade200,
            rankKey: 'total')
      ], rankKey: 'schedule')
    ];
    try {
      _chartKey.currentState.updateData(data);
    } catch (e) {
      debugPrint("EXCEPTION IN CHART ::: $e");
    }

    return [_total, _progged];
  }
}
