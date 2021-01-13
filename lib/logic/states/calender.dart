import 'package:flutter/cupertino.dart';

class CalenderState with ChangeNotifier {
  static final DateTime _today = DateTime.now();
  bool _leap = (_today.year % 4) != 0;
  static final int _minYear = 2020;
  static final int _maxYear = 2021;
  int _year = _today.year;
  int _yearIndex = _today.year > _minYear ? 2 : 1;
  int _month = _today.month - 1;
  int _day = _today.day;
  int _weekDay = _today.weekday;

  int get maxYear => _maxYear;
  int get minYear => _minYear;
  int get yearIndex => _yearIndex;
  int get month => _month;
  int get year => _year;
  bool get leap => _leap;
  int get day => _day;
  int get weekDay => _weekDay;

  set yearIndex(int value) {
    _yearIndex = value;
    List<int> p = [_minYear, _maxYear];
    _year = p[_yearIndex];
    debugPrint("Notifying listerners yearIndex");
    notifyListeners();
  }

  set month(int value) {
    _month = value;
    debugPrint("Notifying listerners month");
    notifyListeners();
  }

  set day(int value) {
    _day = value;
    notifyListeners();
    debugPrint("New Day $_day");
  }

  CalenderState() {
    _setBoundaries();
  }

  void setNewDay(
      {@required int nDay, @required bool inMonth, @required bool preMonth}) {
    if (_day != nDay && inMonth) {
      _day = nDay;
      notifyListeners();
    } else if (!inMonth) {
      if (preMonth) {
        if (_month - 1 < 0) {
          if (_year > _minYear) {
            _year -= 1;
            _yearIndex = 1;
            _month = 11;
          }
        } else {
          _month -= 1;
        }
        _day = nDay;
        notifyListeners();
      } else if (!preMonth) {
        if (_month + 1 > 11) {
          if (_year < _maxYear) {
            _year += 1;
            _yearIndex = 2;
            _month = 0;
          }
        } else {
          _month += 1;
        }
        _day = nDay;
        notifyListeners();
      }
    }
  }

  void _setBoundaries() {
    if (_year > _maxYear) {
      _year = _maxYear;
    } else if (_year < _minYear) {
      _year = _minYear;
    }
  }
}
