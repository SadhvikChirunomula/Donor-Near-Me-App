import 'dart:async';

import 'package:dnmui/screens/OnLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeSplashScreen extends StatefulWidget {
  @override
  _WelcomeSplashScreen createState() => new _WelcomeSplashScreen();
}

class _WelcomeSplashScreen extends State<WelcomeSplashScreen> {
  bool isUserLoggedIn = false;
  String mailid;

  getUserLoggedInDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
      if (isUserLoggedIn) {
        mailid = prefs.getString('mailid');
      } else {
        print("Nothing");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserLoggedInDetail();
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds:
            isUserLoggedIn ? OnLoginPage(mailid: mailid) : LoginPage(),
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
