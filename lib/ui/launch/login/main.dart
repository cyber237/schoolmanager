import 'package:flutter/material.dart';
import 'form.dart';
import '../widgets.dart';
import '../sign_up/main.dart';
import 'forgot_password.dart';
import '../../../logic/states/authentication.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> loginPageScaffKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new ChangeNotifierProvider(
            builder: (context) => new AuthState(),
            child: new Scaffold(
              key: loginPageScaffKey,
              body: new LoginForm(),
              persistentFooterButtons: [
                FooterButton(
                  text: "Sign up instead",
                  side: Side.Left,
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUpPage())),
                ),
                FooterButton(
                    text: "Forgot Password?",
                    side: Side.Right,
                    onTap: () => loginPageScaffKey.currentState
                        .showBottomSheet((context) => ForgotPassword())),
              ],
            )));
  }
}
