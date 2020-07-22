import 'dart:convert';

import 'package:dnmui/screens/DonorRequestPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController emailFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      controller: emailFieldController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final passwordField = TextField(
      obscureText: true,
      controller: passwordFieldController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print('Hello World');
          http.Response response = await http.post(
              'http://35.238.212.200:8080/authenticate',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'mailid': emailFieldController.text,
                'password': passwordFieldController.text
              }));
          print(response.body);
          Map<String, dynamic> data = json.decode(response.body);
          if (data['error'] == null) {
            print(data['status']);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonorRequestPage()),
            );
          } else {
            print(data['error']);
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red[100],
          Colors.white,
          Colors.red[50],
        ])),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(36.0),
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
              SizedBox(height: 10.0),
              emailField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(
                height: 35.0,
              ),
              loginButon,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
