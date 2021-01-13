import 'package:flutter/material.dart';
import 'package:schoolmanager/ui/launch/sign_up/form.dart';
import '../../../globalSettings.dart';
import '../widgets.dart';
import '../login/main.dart';

class TokenForm extends StatefulWidget {
  @override
  _TokenFormState createState() {
    return _TokenFormState();
  }
}

class _TokenFormState extends State<TokenForm> {
  final TextEditingController _tokenController = new TextEditingController();
  String textInBox = "";
  final GlobalKey<ScaffoldState> scaffKey = new GlobalKey();
  final Widget _verificationProgress = new Container(
    width: 30,
    height: 30,
    child: new CircularProgressIndicator(),
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffKey,
      body: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: new SafeArea(
              child: new ListView(
            children: [logo(context, 0.4), _form(context)],
          ))),
      persistentFooterButtons: [
        FooterButton(
          text: "Have an Account?",
          side: Side.Left,
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
        ),
        FooterButton(
          text: "Don't have a Token?",
          side: Side.Right,
          onTap: () {
            scaffKey.currentState.showBottomSheet((context) => _bottomSheet());
          },
        ),
      ],
    );
  }

  Container _form(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _controlWidth = _screenWidth * 0.8;
    final TextStyle _formLabelStyle = new TextStyle(fontSize: 20);
    final Widget tokenField = new Container(
        width: _controlWidth,
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 70,
        child: TextFormField(
            controller: _tokenController,
            onChanged: (v) => setState(() {
                  textInBox = v;
                }),
            decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Token",
                hintText: "Registration Token",
                labelStyle: _formLabelStyle),
            validator: (value) {
              final String g = "Token must be 13 characters";
              if (value.length != 13) {
                return g;
              }
              return null;
            }));

    return new Container(
      alignment: Alignment.center,
      child: new Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: new Column(
            children: [
              tokenField,
              SubmitButton(
                text: "Continue",
                buttColor: MAINHEADTEXTCOLOR,
                textColor: Colors.white,
                onTap: textInBox.length == 13
                    ? () {
                        debugPrint("Showing Snack");
                        Future.delayed(Duration.zero, () {
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                duration: new Duration(seconds: 2),
                                content: new Container(
                                    height: 50,
                                    child: new Row(children: [
                                      _verificationProgress,
                                      new Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: new Text(
                                            "Verifying Token",
                                            style: new TextStyle(fontSize: 18),
                                          )),
                                    ]))));
                        }).whenComplete(() {
                          Future.delayed(
                              Duration(seconds: 2),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignUpForm(
                                          school: "IUC",
                                          department: "INDUSTRIAL",
                                          speciality: "SOFTWARE ENGINEERING",
                                          level: "2"))));
                        });
                      }
                    : null,
              ),
            ],
          )),
    );
  }

  Widget _bottomSheet() {
    return new BottomSheet(
        onClosing: () => null,
        enableDrag: false,
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) {
          return new Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: new Text(
                    "Contact School Administration",
                    style: new TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
                new Text(
                  "Contact your Department coordinator or your school administration to get a registration token.\nThe following data would be necessary :\n1. Your full name.\n2. Your Department\n3. Your Speciality\n4. Your Level\n5. A Piece of identification example(national or school ID)",
                  style:
                      new TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )
              ],
            ),
          );
        });
  }
}
