import 'package:flutter/material.dart';
import 'DonorRequestPage.dart';
import 'package:sms/sms.dart';
import 'package:settings_ui/settings_ui.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String phoneNumber = '9160230298';
  int enteredOtp;


  void sendOtpMethod(String phoneNumber, [String messageText]) {
    SmsSender sender = new SmsSender();
    print("Sent OTP");
  }

  Widget _sendOtpButton() {
    return Material(
//    elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          sendOtpMethod(phoneNumber);
        },
        child: Text("Send OTP", textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon : Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonorRequestPage(mailid :"1234")),
              );
            },
          )
        ],
        title: Text('Settings'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
      body: _sendOtpButton(),
    );
  }
}
