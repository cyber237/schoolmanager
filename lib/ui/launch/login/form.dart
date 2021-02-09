import 'package:flutter/material.dart';
import 'package:schoolmanager/ui/launch/widgets.dart';
import '../../../globalSettings.dart';
import 'package:flutter/widgets.dart';
import '../../../logic/shared/services/authentication/auth.dart';
import '../../../logic/shared/services/authentication/status.dart';
import '../../../main.dart';
import '../../../logic/shared/states/auth.dart';
import 'package:provider/provider.dart';

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
    //final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: new ListView(children: [
        logo(context, 0.4),
        _form(context),
      ]),
    );
  }

  Widget _form(
    BuildContext context,
  ) {
    final TextEditingController idController = new TextEditingController();
    final TextEditingController passController = new TextEditingController();
    final upStream = Provider.of<LoginAuth>(context);
    idController.text = upStream.id;
    passController.text = upStream.password;

    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _controlWidth = _screenWidth * 0.8;
    //final TextStyle _formLabelStyle = new TextStyle(fontSize: 15);
    final Widget useridField = new Container(
        width: _controlWidth,
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 70,
        child: TextFormField(
            initialValue: upStream.id,
            decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: "user ID",
                prefixIcon: new Icon(
                  Icons.person,
                  size: 30,
                )),
            onChanged: (v) => upStream.id = v.trim(),
            validator: (value) {
              final String length = "Must be atleast 6 characters";
              final String format = "Invalid format";
              if (value.length < 6) {
                return length;
              } else if (!value.toLowerCase().startsWith("l") &&
                  !value.toLowerCase().startsWith("s")) {
                return format;
              }
              return null;
            }));

    final Widget passwordField = new Container(
        width: _controlWidth,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          initialValue: upStream.password,
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
              prefixIcon: new Icon(
                Icons.lock,
                size: 30,
              )),
          obscureText: true,
          onChanged: (v) => upStream.password = v.trim(),
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
                  child: new LoginButton(),
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

class LoginButton extends StatelessWidget {
  LoginButton();
  final Auth _auth = new Auth();

  final Widget _verificationProgress = new Container(
    width: 30,
    height: 30,
    child: new CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    final upStream = Provider.of<LoginAuth>(context);
    final Widget snack = SnackBar(
        duration: new Duration(seconds: 7),
        content: new Container(
            height: 50,
            child: new Row(children: [
              _verificationProgress,
              new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: new Text(
                    "Authenticating user",
                    style: new TextStyle(fontSize: 18),
                  )),
            ])));
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.8,
        margin: EdgeInsets.symmetric(vertical: 30),
        height: 70,
        child: new RaisedButton(
          onPressed: upStream.state
              ? () async {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar(reason: SnackBarClosedReason.timeout)
                    ..showSnackBar(snack);
                  await _auth
                      .login(upStream.id, upStream.password)
                      .whenComplete(() {
                    if (_auth.status == Status.Succesfull) {
                      Scaffold.of(context).hideCurrentSnackBar(
                          reason: SnackBarClosedReason.remove);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => new MainApp()));
                    } else {
                      Scaffold.of(context)
                        ..hideCurrentSnackBar(
                            reason: SnackBarClosedReason.remove)
                        ..showSnackBar(new SnackBar(
                            content: new Text(
                                "Couldn't login\nCheck user id and password then try again")));
                    }
                  });
                }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 5,
          color: MAINHEADTEXTCOLOR,
          child: new Text("Login",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
