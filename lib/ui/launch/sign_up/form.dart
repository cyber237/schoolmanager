import 'package:flutter/material.dart';
import '../login/main.dart';
import '../widgets.dart';
import '../../../globalSettings.dart';
import '../../../main.dart';
import '../../../logic/states/authentication.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
      {Key key,
      @required this.school,
      @required this.department,
      @required this.speciality,
      @required this.level})
      : super(key: key);

  final String school;
  final String department;
  final String speciality;
  final String level;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextStyle _labelStyle =
      new TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  final InputBorder _fieldBorder = new OutlineInputBorder();
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
        builder: (context) => new AuthState(),
        child: new Scaffold(
          body: new Container(
              child: new ListView(
            children: [logo(context, 0.25), _form(context)],
          )),
          persistentFooterButtons: [
            FooterButton(
              text: "Already have an account?",
              large: true,
              side: Side.Left,
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return new LoginPage();
                }));
              },
            ),
          ],
        ));
  }

  Widget _form(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Form(
        autovalidateMode: AutovalidateMode.always,
        child: new Column(children: [
          _field(context,
              firstIcon: Icons.account_balance,
              firstLabel: "School",
              firstText: widget.school),
          _field(context,
              firstIcon: Icons.book,
              firstLabel: "Department",
              firstText: widget.department),
          _field(context,
              firstIcon: Icons.school,
              firstLabel: "Speciality",
              firstText: widget.speciality,
              secIcon: Icons.leaderboard,
              secLabel: "Level",
              secText: widget.level),
          Divider(
            indent: _screenWidth * 0.1,
            endIndent: _screenWidth * 0.1,
          ),
          _field(
            context,
            enabled: true,
            firstIcon: Icons.person,
            firstLabel: "Full name *",
          ),
          _field(
            context,
            enabled: true,
            firstIcon: Icons.email,
            keyBoardType: TextInputType.emailAddress,
            firstLabel: "E-mail",
          ),
          _field(
            context,
            enabled: true,
            firstIcon: Icons.phone,
            prefixString: "+237",
            keyBoardType: TextInputType.number,
            firstLabel: "Phone",
          ),
          SubmitButton(
            text: "Sign Up",
            buttColor: MAINHEADTEXTCOLOR.withOpacity(0.9),
            textColor: Colors.white,
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainApp()));
            },
          ),
        ]));
  }

  Widget _field(BuildContext context,
      {bool enabled = false,
      TextEditingController firstController,
      TextEditingController secondController,
      String firstLabel,
      String prefixString,
      String secLabel,
      String firstText,
      TextInputType keyBoardType,
      IconData firstIcon,
      String secText,
      IconData secIcon}) {
    final double _boxWidth = MediaQuery.of(context).size.width * 0.8;
    return secText == null
        ? new Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            height: 60,
            width: _boxWidth,
            child: new TextFormField(
              initialValue: firstText,
              keyboardType: keyBoardType,
              enabled: enabled,
              controller: enabled ? firstController : null,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(2),
                  labelText: firstLabel,
                  labelStyle: _labelStyle,
                  border: _fieldBorder,
                  prefixText: prefixString,
                  prefixIcon: firstIcon != null
                      ? new Icon(
                          firstIcon,
                          size: 25,
                        )
                      : null),
            ))
        : new Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            height: 60,
            width: _boxWidth,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Container(
                    width: _boxWidth * 0.49,
                    child: new TextFormField(
                      initialValue: firstText,
                      enabled: enabled,
                      controller: enabled ? firstController : null,
                      decoration: new InputDecoration(
                          labelText: firstLabel,
                          labelStyle: _labelStyle,
                          contentPadding: EdgeInsets.all(2),
                          border: _fieldBorder,
                          prefixIcon: firstIcon != null
                              ? new Icon(
                                  firstIcon,
                                  size: 25,
                                )
                              : null),
                    )),
                new Container(
                    width: _boxWidth * 0.49,
                    child: new TextFormField(
                      initialValue: secText,
                      enabled: enabled,
                      controller: enabled ? secondController : null,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          labelText: secLabel,
                          labelStyle: _labelStyle,
                          border: _fieldBorder,
                          prefixIcon: secIcon != null
                              ? new Icon(
                                  secIcon,
                                  size: 25,
                                )
                              : null),
                    ))
              ],
            ),
          );
  }
}
