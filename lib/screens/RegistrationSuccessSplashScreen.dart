import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class OnRegistrationSuccess extends StatefulWidget {
  @override
  _OnRegistrationSuccess createState() => new _OnRegistrationSuccess();
}

class _OnRegistrationSuccess extends State<OnRegistrationSuccess> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new LoginPage(),
        title: new Text(
          'OTP Verified Succesfully...',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        loadingText: Text('\n Please wait while we take you to Login Page... \n Please Login to Continue'),
        image: new Image.asset("assets/logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Donor Near Me"),
        loaderColor: Colors.red);
  }
}
