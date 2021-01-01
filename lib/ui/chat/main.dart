import 'package:flutter/material.dart';
import '../../globalSettings.dart';

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
          child: new Text(
        "CHATS Coming Soon",
        style: comingSoonStyle,
      )),
    );
  }
}
