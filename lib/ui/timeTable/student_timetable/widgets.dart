import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'displayBoard.dart';
import '../../../globalSettings.dart';
import '../../../logic/db_models/timetable/timetable.dart';
import '../../../logic/services/timetable/connection.dart';
import '../../../logic/states/timetable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WeekSlides extends StatefulWidget {
  @override
  _WeekSlideState createState() {
    return _WeekSlideState();
  }
}

class _WeekSlideState extends State<WeekSlides> {
  @override
  Widget build(BuildContext context) {
    final upStream = Provider.of<TimeTableNotifier>(context);
    final List<TimeTable> fullData = upStream.fullData ?? tts;

    final TextStyle _labelStyle = new TextStyle(
        color: MAINHEADTEXTCOLOR, fontSize: 18, fontWeight: FontWeight.w400);
    Text _aliasLabel = new Text(upStream.ttAlias,
        textAlign: TextAlign.center, style: _labelStyle);
    Text _upperAlias;
    Text _lowerAlias;

    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 60,
        child: new Swiper(
          outer: true,
          fade: 0.2,
          duration: 500,
          //index: upStream.ttIndex,
          onIndexChanged: (ind) {
            upStream.ttIndex = ind;
          },
          control: SwiperControl(
              color: MAINHEADTEXTCOLOR.withOpacity(0.8),
              size: 20,
              disableColor: Colors.grey.shade400),
          itemCount: fullData.length,
          containerHeight: double.infinity,
          loop: false,
          itemBuilder: (context, index) {
            if (upStream.ttAlias.contains("\n")) {
              _upperAlias = new Text(
                upStream.ttAlias.split("\n")[0],
                textAlign: TextAlign.center,
                style: _labelStyle,
              );
              _lowerAlias = new Text(
                upStream.ttAlias.split("\n")[1],
                textAlign: TextAlign.center,
                style: _labelStyle,
              );
            }
            return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: upStream.data.prevVersion != null &&
                        upStream.ttAlias.contains("\n")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: ClipOval(
                                        child: new Container(
                                          width: 10,
                                          height: 10,
                                          color: Colors.red,
                                        ),
                                      )),
                                  _upperAlias
                                ]),
                            _lowerAlias
                          ])
                    : _aliasLabel);
          },
        ));
  }
}

class TimeTableDisplay extends StatelessWidget {
  final List<String> _weekDays = Shared().weekDays;
  @override
  Widget build(BuildContext context) {
    var upStream = Provider.of<TimeTableNotifier>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: new Column(
        children: [
          DayPicker(),
          _dataDisplay(_weekDays[upStream.dayInfocus], context)
        ],
      ),
    );
  }

  Widget _dataDisplay(String day, BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final BaseWeekObj week =
        new BaseWeekObj(Provider.of<TimeTableNotifier>(context).data);

    final Map dataMap = {
      "mon": week.mon,
      "tue": week.tue,
      "wed": week.wed,
      "thu": week.thu,
      "fri": week.fri,
      "sat": week.sat,
      "sun": week.sun,
    };
    List<Widget> children = [];
    for (int i = 1; i <= dataMap[day].length; i++) {
      children.add(DisplayBoard(
        period: dataMap[day][i - 1],
        width: _screenWidth * 0.9,
        maximized: true,
      ));
    }
    return new Column(
      children: children,
    );
  }
}

class DayPicker extends StatelessWidget {
  final List<String> weekDays = Shared().weekDays;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth,
        height: 70,
        child: new ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          children: weekDays.map((day) => _dayPick(day, context)).toList(),
        ));
  }

  Widget _dayPick(String day, BuildContext context) {
    final upStream = Provider.of<TimeTableNotifier>(context);
    int _indexOfDay = weekDays.indexOf(day);
    bool active = _indexOfDay == upStream.dayInfocus;
    Color _buttColor = active ? MAINHEADTEXTCOLOR : null;
    Color _textColor = active ? Colors.white : MAINHEADTEXTCOLOR;
    return new GestureDetector(
      onTap: () {
        if (!(active)) {
          upStream.dayInfocus = _indexOfDay;
        }
      },
      child: new Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 60,
          decoration: new BoxDecoration(
              border: Border.all(color: MAINHEADTEXTCOLOR),
              color: _buttColor,
              borderRadius: BorderRadius.circular(10)),
          child: new Text(day.toUpperCase(),
              style: new TextStyle(
                  fontSize: 15,
                  color: _textColor,
                  fontWeight: FontWeight.w600))),
    );
  }
}
