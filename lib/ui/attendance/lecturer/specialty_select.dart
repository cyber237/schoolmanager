import 'package:flutter/material.dart';

class SpecialitySelect extends StatelessWidget {
  const SpecialitySelect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new _SpecialitySelectBody(),
    );
  }
}

class _SpecialitySelectBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new ListView(),
    );
  }
}
