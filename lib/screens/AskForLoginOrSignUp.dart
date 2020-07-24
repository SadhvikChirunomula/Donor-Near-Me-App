import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:splashscreen/splashscreen.dart';

import 'ContactUsPage.dart';
import 'FactsPage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class AskForLoginOrSignUp extends StatefulWidget {
  @override
  _AskForLoginOrSignUp createState() => new _AskForLoginOrSignUp();
}

class _AskForLoginOrSignUp extends State<AskForLoginOrSignUp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new AfterSplash(),
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

class AfterSplash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Colors.lightBlueAccent;
          print("Taking you to Login Page");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("Login", textAlign: TextAlign.center),
      ),
    );
    final registerButon = Material(
      elevation: 5.0,
      color: Colors.greenAccent,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Taking you to Register Page");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
        child: Text("Register", textAlign: TextAlign.center),
      ),
    );
    final factsButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          color:
          Colors.lightBlueAccent;
          print("Taking you to Facts Page");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FactsPage()),
          );
        },
        child: Text("Get Facts", textAlign: TextAlign.center),
      ),
    );

    Future<void> share() async {
      await FlutterShare.share(
          title: 'Donor Near Me',
          text: 'Click on the URL below to download the App',
          linkUrl: 'http://donornearme.com/',
          chooserTitle: 'Find a blood donor near you!'
      );
    }

    return Scaffold(
        appBar: AppBar(
            title: Text('Welcome To Donor Near Me'),
            backgroundColor: Colors.red,
            brightness: Brightness.dark,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  share();
                },
              )
            ]),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red[400],
//            Colors.white,
            Colors.red[600],
            Colors.red[400],
//                Colors.black,
          ])),
          child: Center(
              child: Padding(
            padding: new EdgeInsets.only(left: 30, right: 30),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                loginButon,
                SizedBox(
                  height: 20.0,
                ),
                registerButon,
                SizedBox(
                  height: 20.0,
                ),
                factsButton,
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )),
        ),
        floatingActionButton: Container(
            height: 75.0,
            width: 75.0,
            child: FloatingActionButton(
              child: Text("Contact Us"),
              onPressed: () {
                print("Taking you to Contact Us Page");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            )));
  }
}
