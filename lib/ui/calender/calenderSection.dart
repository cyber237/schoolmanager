import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CalenderSection extends StatefulWidget {
  CalenderSection({Key key}) : super(key: key);

  @override
  _CalenderSectionState createState() => _CalenderSectionState();
}

class _CalenderSectionState extends State<CalenderSection> {
  List<String> _months = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "decemder"
  ];

  final SwiperController _monthSwipeControl = new SwiperController();
  int _currentMonthindex = 0;

  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
      width: _screenWidth * 0.9,
      height: 600,
      child: new Column(
        children: [
          //new Expanded(child: ,flex: 1,)
          _head()
        ],
      ),
    );
  }

  Widget _head() {
    return new Container(
      child: new Row(),
    );
  }

  Widget _monthslider() {
    return new Container(
      width: 80,
      height: 100,
      child: new Swiper(
        itemCount: _months.length,
        index: _currentMonthindex,
        onIndexChanged: (ind) => setState(() => _currentMonthindex = ind),
        controller: _monthSwipeControl,
        containerHeight: double.infinity,
        containerWidth: 100,
        itemBuilder: (context, index) {
          return new Text(
              _months[_currentMonthindex].substring(0, 3).toUpperCase(),
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700));
        },
      ),
    );
  }
}
