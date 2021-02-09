import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:provider/provider.dart';
import '../../logic/shared/states/calender.dart';

class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
        builder: (_) => new CalenderState(),
        child: new Scaffold(
          appBar: new AppBar(
            title: new CalenderHead(),
          ),
          body: new MonthBody(),
        ));
  }
}
