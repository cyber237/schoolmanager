import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new BottomSheet(
        onClosing: () => null,
        enableDrag: false,
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) {});
  }

  Widget _verificationForm(BuildContext context) {
    return new Container();
  }

  Widget _contactAdmin() {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: new Text(
              "Password Recovery Process",
              style: new TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          new Text(
            "Contact your Department coordinator or your school administration to recover your password.\nThe following data would be necessary :\n1. Your full name.\n2. Your Department\n3. Your Speciality\n4. Your Level\n5. A Piece of identification example(national or school ID)",
            style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
