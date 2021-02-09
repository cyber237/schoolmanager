import 'package:flutter/material.dart';
import 'form.dart';
import '../widgets.dart';
import '../sign_up/main.dart';
import 'forgot_password.dart';
import '../../../logic/shared/states/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> loginPageScaffKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      key: loginPageScaffKey,
      body: new ChangeNotifierProvider(
          builder: (context) => LoginAuth(), child: new LoginForm()),
      persistentFooterButtons: [
        FooterButton(
          text: "Sign up instead",
          side: Side.Left,
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new SignUpPage())),
        ),
        FooterButton(
            text: "Forgot Password?",
            side: Side.Right,
            onTap: () => loginPageScaffKey.currentState
                .showBottomSheet((context) => new ForgotPassword())),
      ],
    ));
  }
}
