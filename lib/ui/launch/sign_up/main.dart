import 'package:flutter/material.dart';
import 'token_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      body: TokenForm(),
    ));
  }
}
