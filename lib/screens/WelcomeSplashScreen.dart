import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'LoginPage.dart';

class WelcomeSplashScreen extends StatefulWidget {
  @override
  _WelcomeSplashScreen createState() => new _WelcomeSplashScreen();
}

class _WelcomeSplashScreen extends State<WelcomeSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new LoginPage(),
        title: new Text(
          'Welcome to Donor Near Me',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        image: new Image.asset("assets/logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Donor Near Me"),
        loaderColor: Colors.red);
  }
}
