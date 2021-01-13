import 'package:flutter/material.dart';
import 'package:schoolmanager/ui/launch/widgets.dart';
import '../../../globalSettings.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animationU, animationP, animationS;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 1), vsync: this);
    animationU = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut));
    animationP = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.elasticInOut)));
    animationS = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.elasticInOut)));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: new ListView(children: [
        logo(context, 0.4),
        _form(context),
      ]),
    );
  }

  Container _form(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _controlWidth = _screenWidth * 0.8;
    final TextStyle _formLabelStyle = new TextStyle(fontSize: 15);
    final Widget useridField = new Container(
        width: _controlWidth,
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 70,
        child: TextFormField(
            decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: "user ID",
                prefixIcon: new Icon(
                  Icons.person,
                  size: 30,
                )),
            validator: (value) {
              final String g = "Must be atleast 13 characters";
              if (value.length < 13) {
                return g;
              }
              return null;
            }));

    final Widget passwordField = new Container(
        width: _controlWidth,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
              prefixIcon: new Icon(
                Icons.lock,
                size: 30,
              )),
          obscureText: true,
        ));
    return new Container(
      child: new Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: new Column(
            children: [
              AnimatedBuilder(
                  child: useridField,
                  animation: animationU,
                  builder: (context, child) {
                    return new Transform(
                      child: child,
                      transform: Matrix4.translationValues(
                          animationU.value * _screenWidth, 0, 0),
                    );
                  }),
              AnimatedBuilder(
                  child: passwordField,
                  animation: animationP,
                  builder: (context, child) {
                    return new Transform(
                      child: child,
                      transform: Matrix4.translationValues(
                          animationP.value * _screenWidth, 0, 0),
                    );
                  }),
              AnimatedBuilder(
                  child: SubmitButton(
                    text: "Login",
                    buttColor: MAINHEADTEXTCOLOR,
                    textColor: Colors.white,
                  ),
                  animation: animationS,
                  builder: (context, child) {
                    return new Transform(
                      child: child,
                      transform: Matrix4.translationValues(
                          animationS.value * _screenWidth, 0, 0),
                    );
                  }),
            ],
          )),
    );
  }
}
