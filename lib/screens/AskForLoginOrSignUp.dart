import 'package:flutter/material.dart';

import 'ContactUsPage.dart';
import 'file:///F:/dnmuiapp/dnmui/lib/screens/LoginPage.dart';
import 'file:///F:/dnmuiapp/dnmui/lib/screens/RegisterPage.dart';

import 'FactsPage.dart';

class AskForLoginOrSignUp extends StatelessWidget {
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
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
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

    return Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome To Donor Near Me'),
//          backgroundColor: Colors.redAccent,
//          brightness: Brightness.dark,
//          centerTitle: true,
//        ),
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
                new Text(
                  'Welcome To Donor Near Me',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
//                      backgroundColor: Colors. ,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: 'Open Sans'),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                print("Thankyou for the comment!!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            )));
  }
}
