import 'package:flutter/material.dart';
import 'package:schoolmanager/logic/shared/db_models/user/user.dart';
import 'package:schoolmanager/logic/shared/database/user.dart';
import 'package:schoolmanager/main.dart';

class AccountSetup extends StatefulWidget {
  AccountSetup({Key key}) : super(key: key);

  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      await UserDB().getUser().then(
          (user) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => MainApp(
                    user: user,
                  ))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
                width: 200,
                height: 200,
                child: new CircularProgressIndicator()),
            new Text("Just a sec...\nYour account is being setted up")
          ]),
    );
  }
}
