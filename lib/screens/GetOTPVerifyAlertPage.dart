import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'RegistrationSuccessSplashScreen.dart';

class GetOTPVerifyAlertPage extends StatefulWidget {
  final String userDetailsJson;

  @override
  GetOTPVerifyAlertPage({Key key, @required this.userDetailsJson}): super(key: key);

  @override
  _GetOTPVerifyAlertPage createState() => new _GetOTPVerifyAlertPage(userDetailsJson);
}

class _GetOTPVerifyAlertPage extends State<GetOTPVerifyAlertPage> {
  String userDetailsJson;
  _GetOTPVerifyAlertPage(this.userDetailsJson);

  TextEditingController otpFieldController = new TextEditingController();
  String error = 'Please Enter OTP';
  bool wrongOtp = false;
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

  Widget _enterOtpText(bool wrongOtp){
    if(wrongOtp){
      print("Please check OTP again 90" );
      return Text('Please check OTP again');
    }else {
      print("94");
      return Text('Please Enter OTP');
    }
  }

  Widget _wrongOtpEnteredMessage(){
    return Text('Please check OTP again');
  }


  @override
  Widget build(BuildContext context) {
    final Map userDetailsMap = jsonDecode(userDetailsJson);
    Alert(
        context: context,
        title: "Verify OTP",
        content:  Column(
          children: <Widget>[
            TextField(
              controller: otpFieldController,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: 'OTP',
              ),
            ),
            _enterOtpText(wrongOtp),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
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
                if (addedData['status'] == 'Added User Succesfully. Please sign in to continue') {
                  print('Hello World');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnRegistrationSuccess()),
                  );
                }else{
                  print('Failed to add User');
                }
              }else{
                setState(() {
                  print(wrongOtp);
                  wrongOtp = true;
                  print(wrongOtp);
                });
                print("Wrong OTP Entered");
              }
            },
            child: Text(
              "Verify",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();


  }
}
