import 'dart:convert';

import 'package:dnmui/models/RegisterScreenModel/GetUserOtpRequest.dart';
import 'package:dnmui/models/RegisterScreenModel/SendOtpRequest.dart';
import 'package:dnmui/models/RegisterScreenModel/ValidateOtpRequest.dart';
import 'package:dnmui/screens/LoginPage.dart';
import 'package:dnmui/screens/OnOTPVerificationSuccess.dart';
import 'package:dnmui/services/RegisterScreenService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fswitch/fswitch.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sms/sms.dart';

import 'AskForLoginOrSignUp.dart';

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
  String userDetailsJson = '';
  String fcmToken = '';
  String error = 'Please Enter OTP';
  bool wrongOtp = false;
  bool smsNotification = true;
  bool mailNotification = true;
  bool _passwordVisible = false;
  RegisterScreenService registerScreenService = new RegisterScreenService();
  ValidateOtpRequest validateOtpRequest;
  SendOtpRequest sendOtpRequest;
  GetUserOtpRequest getUserOtpRequest;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _firebaseRegister();
    super.initState();
    _getBloodGroupsList();
  }

  _getBloodGroupsList() async {
    Map<String, dynamic> data =
        await registerScreenService.getBloodGroupsList();
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
      'fcmToken': userDetailsMap['fcmToken']
    };
  }

  _validateOtp(Map userDetailsMap, String otp) async {
    validateOtpRequest = new ValidateOtpRequest();
    validateOtpRequest.mailid = userDetailsMap['mailid'];
    validateOtpRequest.otp = otp;
    Map<String, dynamic> data =
        await registerScreenService.validateOtp(validateOtpRequest);
    // print(_userDetailsMapToJson(userDetailsMap));
    if (data['error'] == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OnOTPVerificationSuccessPage(userDetailsJson: userDetailsJson)),
      );
    } else {
      setState(() {
        wrongOtp = true;
      });
      wrongOtpEnteredAlert();
      print("Wrong OTP Entered");
    }
  }

  _getOTPVerifyAlertPage(String userDetails) {
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
    return new Text('Please check OTP again');
  }

  wrongOtpEnteredAlert() {
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
    print("Trying to get FCM Token..");
    FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) => setState(() {
          fcmToken = token;
          print("Firebase Register :" + fcmToken);
        }));

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      setState(() {
        fcmToken = newToken;
      });

      print("New Token :" + newToken);
    });
  }

  Widget _getHelloUserText() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.orange,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 42.0, vertical: 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hello, ",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Please enter you Name, Emailid, Phone Number, Blood Group. \n"
                      "These Details are kept confidential.\n \n"
                      "Once you enter your details and click on Register, an OTP will be sent the registered Mailid and Phonenumber. Please enter OTP to continue",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _sendOtpAsSms(String phoneNumber, String otp) {
    SmsSender sender = new SmsSender();
    sender.sendSms(
        new SmsMessage(phoneNumber, 'OTP for Donor Near Me is ' + otp));
    print("Sent OTP");
  }

  void _readSMSMethod() {
    SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage msg) => print(msg.body));
  }

  Widget _getFullNameField() {
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

  Widget _getEmailField() {
    return Container(
        width: double.infinity,
        child: TextField(
          style: TextStyle(fontSize: 20.0, color: Colors.black),
          controller: emailFieldController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email ID",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getPasswordField() {
    return Container(
        width: double.infinity,
        child: TextField(
          controller: passwordFieldController,
          obscureText: !_passwordVisible,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )),
        ));
  }

  Widget _getMobileNumberField() {
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

  Widget _getBloodGroupField() {
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
        hint: Text(
          'Blood Group',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
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

  Widget _getSmsNotificationButton() {
    return FSwitch(
      onChanged: (bool value) {
        smsNotification = value;
        print(smsNotification);
      },
      open: false,
      enable: true,
      shadowColor: Colors.black.withOpacity(0.5),
      color: Colors.red,
      width: double.infinity,
      height: 28,
      shadowBlur: 3.0,
    );
  }

  Widget _getMailNotificationButton() {
    return FSwitch(
      onChanged: (bool value) {
        mailNotification = value;
        print(mailNotification);
      },
      open: false,
      enable: true,
      shadowColor: Colors.black.withOpacity(0.5),
      color: Colors.red,
      width: double.infinity,
      height: 28,
      shadowBlur: 3.0,
    );
  }

  Widget _getRegisterButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          sendOtpRequest = new SendOtpRequest();
          print("Token of the User is :" + fcmToken);
          sendOtpRequest.mailid = emailFieldController.text;
          http.Response response =
              await registerScreenService.sendOtpToUser(sendOtpRequest);
          Map<String, dynamic> userMap = new Map();
          String _mailid = emailFieldController.text;
          String _password = passwordFieldController.text;
          String _phoneNumber = mobileNumberFieldController.text;
          String _fullName = fullNameFieldController.text;
          userDetailsJson = '''{
            "mailid":"$_mailid",
            "phonenumber":"$_phoneNumber",
            "password":"$_password",
            "fullName":"$_fullName"
          }''';
          // userDetailsJson = jsonEncode(_userDetailsMapToJson());
          print("User Details Json : " + userDetailsJson);
          print(response.statusCode);
          if (response.statusCode == 200) {
            _getOtp(emailFieldController.text);
            await Future.delayed(const Duration(seconds: 2));
            print("OTP : " + otp);
            _sendOtpAsSms(mobileNumberFieldController.text, otp);
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
    getUserOtpRequest = new GetUserOtpRequest();
    getUserOtpRequest.mailid = mailid;
    Map<String, dynamic> data =
        await registerScreenService.getUserOtp(getUserOtpRequest);
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            )
          ]),
      body: Container(
        height: double.infinity,
//        width: double.infinity,
        decoration: BoxDecoration(
//            gradient:
//                LinearGradient(colors: [Colors.red[100], Colors.red[200]])
            ),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getHelloUserText(),
              SizedBox(height: 30.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getEmailField()),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getFullNameField()),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getPasswordField()),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getMobileNumberField()),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getBloodGroupField()),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getRegisterButton()),
              SizedBox(height: 20.0),
            ],
          ),
        ),
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
