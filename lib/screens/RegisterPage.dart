import 'dart:convert';

import 'package:dnmui/screens/OnOTPVerificationSuccess.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sms/sms.dart';

import 'AskForLoginOrSignUp.dart';
import 'RegistrationSuccessSplashScreen.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController fullNameFieldController = new TextEditingController();
  TextEditingController emailFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();
  TextEditingController mobileNumberFieldController =
      new TextEditingController();
  String otp = '';
  String bloodGroup;
  List<String> bloodGroupsList = [];
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String userDetailsJson= '';
  String fcmtoken = '';
  String error = 'Please Enter OTP';
  bool wrongOtp = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBloodGroupsList();
  }

  _getBloodGroupsList() async {
    var response =
        await http.get('http://35.238.212.200:8080/getlist/bloodgroups');
    Map<String, dynamic> data = json.decode(response.body);
    bloodGroupsList = [];
    setState(() {
      var jsonList = data['bloodGroupsList']['blood_group'];
      for (String x in jsonList) {
        bloodGroupsList.add(x);
      }
    });
  }

  Map<String, dynamic> _userDetailsMapToJson(Map userDetailsMap) {
    return <String, dynamic>{
      'bloodgroup': userDetailsMap['bloodgroup'],
      'mail_notification': userDetailsMap['mail_notification'],
      'mailid': userDetailsMap['mailid'],
      'password': userDetailsMap['password'],
      'phonenumber': userDetailsMap['phonenumber'],
      'sms_notification': userDetailsMap['sms_notification'],
      'username': userDetailsMap['username'],
      'fcmtoken': userDetailsMap['fcmtoken']
    };
  }

  _validateOtp(Map userDetailsMap, String otp) async {
    http.Response response = await http.post(
        'http://35.238.212.200:8080/validateotp',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': userDetailsMap['mailid'],
          'otp': otp
        }));
    Map<String, dynamic> data = json.decode(response.body);
    print(_userDetailsMapToJson(userDetailsMap));
    if (data['error'] == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnOTPVerificationSuccessPage(userDetailsJson: userDetailsJson)),
      );
    } else {
      setState(() {
        wrongOtp = true;
      });
      wrongOtpEnteredAlert();
      print("Wrong OTP Entered");
    }
  }

  Widget _getOTPVerifyAlertPage(String userDetails) {
    Map userDetailsMap = jsonDecode(userDetails);

    Alert(
        context: context,
        title: "Please Enter OTP",
        content: Column(
          children: <Widget>[
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              style: TextStyle(fontSize: 20),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                _validateOtp(userDetailsMap, pin);
              },
            ),
            Container(
              child: Text(
                  "OTP has been sent to the registered mailid and registered Phone Number. Please verify to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
//                  fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
            )
          ],
        ),
        buttons: []).show();
  }

  Widget _enterOtpText(bool wrongOtp) {
    if (wrongOtp) {
      print("Please check OTP again 90");
      return Text('Please check OTP again');
    } else {
      print("94");
      return Text('Please Enter OTP');
    }
  }

  Widget _wrongOtpEnteredMessage() {
    return Text('Please check OTP again');
  }

  Widget wrongOtpEnteredAlert() {
    Alert(
        context: context,
        title: "Verify OTP",
        desc: "OTP Entered is Wrong",
        buttons: [
          DialogButton(
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Re-Enter OTP",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  _firebaseRegister() {
    _firebaseMessaging.deleteInstanceID();
    _firebaseMessaging.getToken().then((token) => fcmtoken = token);
  }

  void _sendOtpMethod(String phoneNumber, String otp) {
    SmsSender sender = new SmsSender();
    sender.sendSms(
        new SmsMessage(phoneNumber, 'OTP for Donor Near Me is ' + otp));
    print("Sent OTP");
  }

  void _readSMSMethod() {
    SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage msg) => print(msg.body));
  }

  Widget _getFullNameField(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: fullNameFieldController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Full Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getEmailField(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: emailFieldController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getPasswordField(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: passwordFieldController,
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getMobileNumberField(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: mobileNumberFieldController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Mobile Number",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getBloodGroupField(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: bloodGroup,
        hint: Text('Blood Group'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            bloodGroup = newValue;
          });
        },
        items: bloodGroupsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getRegisterButton(){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _firebaseRegister();
          print("Token of the User is :" + fcmtoken);
          setState(() {
            userDetailsJson = jsonEncode(<String, String>{
              'bloodgroup': bloodGroup,
              'mail_notification': 'true',
              'mailid': emailFieldController.text,
              'password': passwordFieldController.text,
              'phonenumber': mobileNumberFieldController.text,
              'sms_notification': 'true',
              'username': fullNameFieldController.text,
              'fcmtoken': fcmtoken
            });
          });
          print(userDetailsJson);
          http.Response response =
          await http.post('http://35.238.212.200:8080/sendotp',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'mailid': emailFieldController.text,
              }));
          print(response.statusCode);
          if (response.statusCode == 200) {
            _getOtp(emailFieldController.text);
            await Future.delayed(const Duration(seconds: 2));
            print("OTP : " + otp);
            _sendOtpMethod(mobileNumberFieldController.text, otp);
            print("Taking you to OTP Page");
            _getOTPVerifyAlertPage(userDetailsJson);
          } else {
            print("Please try again Later");
          }
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  _getOtp(String mailid) async {
    print("Mailid for OTP : " + mailid);
    http.Response response = await http.get(
        'http://35.238.212.200:8080/getuserotp?mailid='+mailid,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    Map<String, dynamic> data = json.decode(response.body);
    print("OTP in data : " + data['otp']);
      setState(() {
        otp = data['otp'];
        print("OTP after setting state: " + otp);
      });
//    if(data['status']=='Got Otp') {
//      setState(() {
//        otp = data[otp];
//      });
//    }
//    else{
//      setState(() {
//        otp = 'We are not able to send otp';
//      });
//    }
    return otp;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Register'),
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
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.red[100], Colors.red[200]])),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getFullNameField(),
              SizedBox(height: 10.0),
              _getEmailField(),
              SizedBox(height: 10.0),
              _getPasswordField(),
              SizedBox(height: 10.0),
              _getMobileNumberField(),
              SizedBox(height: 10.0),
              _getBloodGroupField(),
              SizedBox(height: 10.0),
              _getRegisterButton(),
            ],
          ),
        )),
      ),
//        floatingActionButton: Container(
//            height: 100.0,
//            width: 100.0,
//            child: FloatingActionButton(
//              child: Text("Comment"),
//              onPressed: () {
//                print("Thankyou for the comment!!");
//              },
//            ))
    );
  }
}
