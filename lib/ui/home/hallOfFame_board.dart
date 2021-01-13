import 'package:flutter/material.dart';
import 'homeGlobalsettings.dart';

class HallFameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * cardwidthRatio,
        height: 300,
        child: new InkWell(
            onTap: () => null,
            child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                elevation: 5,
                child: new Container())));
  }
}
