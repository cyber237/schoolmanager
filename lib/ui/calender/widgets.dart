import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../logic/states/calender.dart';

class Shared {
  final List<String> months = [
    "jan",
    "feb",
    "mar",
    "apr",
    "may",
    "jun",
    "jul",
    "aug",
    "sep",
    "oct",
    "nov",
    "dec"
  ];
}

class CalenderHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var upStream = Provider.of<CalenderState>(context);
    return new Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Text("${upStream.year}"),
          _monthsSwiper(upStream, context)
        ],
      ),
    );
  }

  Widget _monthsSwiper(CalenderState upStream, BuildContext context) {
    return new Container(
        width: 40,
        height: 40,
        child: new Swiper.children(
              loop: false,
              index: upStream.month,
              children: new Shared()
                  .months
                  .map((e) => new Text(e.toString()))
                  .toList(),
              onIndexChanged: (v) => upStream.month = v,
            ) ??
            new Text(Shared().months[upStream.month]));
  }
}

class MonthBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var upStream = Provider.of<CalenderState>(context);
    debugPrint("Getting monthList");
    List<Widget> monthList = getMonthList(context, upStream);
    debugPrint("Done Getting monthList");
    return new Container(
      child: new GridView.count(
        children: monthList,
        crossAxisCount: 7,
      ),
    );
  }

  List<Widget> getMonthList(BuildContext context, CalenderState upStream) {
    List<Widget> monthList = [];
    final List<String> m = Shared().months;
    final Map<String, int> monthCount = {
      m[0]: 31,
      m[1]: upStream.leap ? 29 : 28,
      m[2]: 31,
      m[3]: 30,
      m[4]: 31,
      m[5]: 30,
      m[6]: 31,
      m[7]: 31,
      m[8]: 30,
      m[9]: 31,
      m[10]: 30,
      m[11]: 31
    };
    final DateTime _monthStart =
        new DateTime(upStream.year, upStream.month + 1, 1);
    if (_monthStart.weekday != 1) {
      int mi = upStream.month - 1 == -1 ? 11 : upStream.month - 1;
      for (int i = (monthCount[m[mi]] - _monthStart.weekday + 2);
          i <= monthCount[m[mi]];
          i++) {
        monthList.add(DayIcon(
          day: i,
          inMonth: false,
          preMonth: true,
        ));
      }
    }
    bool inDay;
    for (int i = 0; i < monthCount[m[upStream.month]]; i++) {
      inDay = (i + 1 == upStream.day);

      monthList.add(DayIcon(
        day: i + 1,
        currentDay: inDay,
        inMonth: true,
      ));
    }

    int max = 35;
    if (monthCount[m[upStream.month]] > 30 && _monthStart.weekday > 5) {
      max = 42;
    }
    int diff = max - monthList.length;
    if (monthList.length < max) {
      for (int c = 0; c < diff; c++) {
        monthList.add(
          DayIcon(
            day: c + 1,
            inMonth: false,
            preMonth: false,
          ),
        );
      }
    }
    return monthList;
  }
}

class DayIcon extends StatelessWidget {
  DayIcon(
      {this.day,
      this.currentDay = false,
      this.inMonth = false,
      this.preMonth = false});
  final int day;
  final bool currentDay;
  final bool preMonth;
  final bool inMonth;
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    var upStream = Provider.of<CalenderState>(context);
    return new GestureDetector(
      onTap: () {
        upStream.setNewDay(nDay: day, inMonth: inMonth, preMonth: preMonth);
      },
      child: new Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: new ClipOval(
            child: new Container(
              width: _screenWidth / 7,
              height: _screenWidth / 7,
              color: currentDay ? Colors.blue : null,
              child: new Center(child: new Text("$day")),
            ),
          )),
    );
  }
}
