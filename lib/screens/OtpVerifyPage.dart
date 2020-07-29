import 'dart:convert';

import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AskForLoginOrSignUp.dart';

class OtpVerifyPage extends StatefulWidget {
  String userDetails;

  OtpVerifyPage({Key key, @required this.userDetails}) : super(key: key);

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState(userDetails);
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String userDetails;
  TextEditingController otpFieldController = new TextEditingController();
  String error = '';
  String addedUserStatus = 'Please Verify Email..';
  Material continueToLoginButton = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: null,
      child: Text("Verify OTP to Continue ", textAlign: TextAlign.center),
    ),
  );

  _OtpVerifyPageState(this.userDetails);

  Map<String, dynamic> _userDetailsMapToJson(Map userDetailsMap) {
    return <String, dynamic>{
      'bloodgroup': userDetailsMap['bloodgroup'],
      'city': userDetailsMap['city'],
      'country': userDetailsMap['country'],
      'district': userDetailsMap['district'],
      'mail_notification': userDetailsMap['mail_notification'],
      'mailid': userDetailsMap['mailid'],
      'password': userDetailsMap['password'],
      'phonenumber': userDetailsMap['phonenumber'],
      'pincode': userDetailsMap['pincode'],
      'sms_notification': userDetailsMap['sms_notification'],
      'state': userDetailsMap['state'],
      'town': userDetailsMap['town'],
      'username': userDetailsMap['username'],
      'fcmtoken': userDetailsMap['fcmtoken']
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map userDetailsMap = jsonDecode(userDetails);
    final otpField = TextField(
      obscureText: false,
      controller: otpFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "OTP",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final contToLoginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("Go to Login Page", textAlign: TextAlign.center),
      ),
    );

    final submitOtpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          error = '';
          http.Response response = await http.post(
              'http://35.238.212.200:8080/validateotp',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'mailid': userDetailsMap['mailid'],
                'otp': otpFieldController.text
              }));
          Map<String, dynamic> data = json.decode(response.body);
          print(_userDetailsMapToJson(userDetailsMap));
          if (data['error'] == null) {
            http.Response response =
                await http.post('http://35.238.212.200:8080/addUser',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'bloodgroup': userDetailsMap['bloodgroup'],
                      'city': userDetailsMap['city'],
                      'country': userDetailsMap['country'],
                      'district': userDetailsMap['district'],
                      'mail_notification': userDetailsMap['mail_notification'],
                      'mailid': userDetailsMap['mailid'],
                      'password': userDetailsMap['password'],
                      'phonenumber': userDetailsMap['phonenumber'],
                      'pincode': userDetailsMap['pincode'],
                      'sms_notification': userDetailsMap['sms_notification'],
                      'state': userDetailsMap['state'],
                      'town': userDetailsMap['town'],
                      'username': userDetailsMap['username'],
                      'fcmtoken': userDetailsMap['fcmtoken']
                    }));

            print("Add User Response " + response.body);
            Map<String, dynamic> addedData = json.decode(response.body);
            if (addedData['status'] ==
                'Added User Succesfully. Please sign in to continue') {
              print('Hello World');
              setState(() {
                addedUserStatus = 'OTP Verified Succesfully...\n Click on Go To Login Page to Continue..';
                continueToLoginButton = contToLoginButon;
              });
              print(addedUserStatus);
            }
          } else {
            setState(() {
              error = data['error'];
            });
          }
        },
        child: Text(
          "Submit OTP",
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('OTP Verification'),
          backgroundColor: Colors.redAccent,
          brightness: Brightness.dark,
          centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AskForLoginOrSignUp()),
                  );
                },
              )
            ]
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
                Container(
                    child: Text(
                  addedUserStatus,
                  textAlign: TextAlign.justify,
                  style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontSize: 20),
                )),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(height: 10.0),
                otpField,
                SizedBox(height: 25.0),
                submitOtpButton,
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                    child: Text(
                  error,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(child: continueToLoginButton)
              ],
            ),
          )),
        ));
  }
}
