import 'dart:convert';

import 'package:dnmui/screens/AskForLoginOrSignUp.dart';
import 'package:dnmui/screens/LoginPage.dart';
import 'package:dnmui/screens/PostContactUs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController emailFieldController = new TextEditingController();
  TextEditingController phoneNumberFieldController =
      new TextEditingController();
  TextEditingController fullNameFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      controller: emailFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final phoneNumberField = TextField(
      obscureText: false,
      controller: emailFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Phone Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final fullNameField = TextField(
      obscureText: false,
      controller: emailFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Full Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final contactUsButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            http.Response response =
                await http.post('http://35.238.212.200:8080/contactus',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'mailid': emailFieldController.text,
                      'phonenumber': phoneNumberFieldController.text,
                      'username': fullNameFieldController.text,
                    }));

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostContactUsPage()),
            );
          },
          child: Text("Submit", textAlign: TextAlign.center)),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Contact Us'),
          backgroundColor: Colors.redAccent,
          brightness: Brightness.dark,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            )
          ]),
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
              fullNameField,
              SizedBox(height: 25.0),
              emailField,
              SizedBox(height: 25.0),
              phoneNumberField,
              SizedBox(
                height: 35.0,
              ),
              contactUsButon,
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
