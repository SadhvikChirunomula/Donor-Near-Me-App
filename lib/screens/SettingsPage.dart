import 'dart:convert';

import 'package:dnmui/models/SettingsScreenModel/GetUserDetailsRequest.dart';
import 'package:dnmui/models/SettingsScreenModel/UpdateUserRequest.dart';
import 'package:dnmui/screens/OnLoginPage.dart';
import 'package:dnmui/services/SettingsScreenService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:input_sheet/components/IpsCard.dart';
import 'package:input_sheet/components/IpsError.dart';
import 'package:input_sheet/components/IpsIcon.dart';
import 'package:input_sheet/components/IpsLabel.dart';
import 'package:input_sheet/components/IpsValue.dart';
import 'package:input_sheet/input_sheet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'DonorRequestPage.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.mailid}) : super(key: key);
  final String mailid;

  @override
  _SettingsPageState createState() => _SettingsPageState(mailid);
}

class _SettingsPageState extends State<SettingsPage> {
  String mailid;
  String _fullName;
  String _password;
  String _smsNotification;
  String _mailNotification;
  String _mobileNumber;
  String _bloodGroup;
  String updatedUserDetailsJson;
  GetUserDetailsRequest getUserDetailsRequest;
  UpdateUserRequest updateUserRequest;
  SettingsScreenService settingsScreenService = new SettingsScreenService();

  _SettingsPageState(this.mailid);

  Map<String, dynamic> userDetailsMap = new Map();

  @override
  void initState() {
    // TODO: implement initState
    _getUserDetails(mailid);
  }

  _getUserDetails(String mailid) async {
    getUserDetailsRequest = new GetUserDetailsRequest();
    getUserDetailsRequest.mailid = mailid;

    Map<String, dynamic> data =
        await settingsScreenService.getUserDetails(getUserDetailsRequest);

    setState(() {
      userDetailsMap = data['userDetails'][0];
      _fullName = userDetailsMap['username'];
      _mobileNumber = userDetailsMap['phonenumber'];
      _bloodGroup = userDetailsMap['bloodgroup'];
      _password = userDetailsMap['password'];
      bool smsNotificationBool = userDetailsMap['sms_notification'];
      if (smsNotificationBool) {
        _smsNotification = 'true';
      } else {
        _smsNotification = 'false';
      }
      bool mailNotificationBool = userDetailsMap['mail_notification'];
      if (mailNotificationBool) {
        _mailNotification = 'true';
      } else {
        _mailNotification = 'false';
      }
    });
    print(userDetailsMap);
  }

  Map<String, dynamic> _errors = new Map<String, dynamic>();

  Widget _getIPSCardName() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Name"),
      value: IpsValue(_fullName ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Name",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _fullName,
        onDone: (dynamic value) => setState(() {
          _fullName = value;
          print(_fullName);
        }),
      ),
    );
  }

  Widget _getIPSCardBloodGroup() {
    return IpsCard(
      label: IpsLabel("Blood Group"),
      value: IpsValue(_bloodGroup ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Blood Group",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _bloodGroup,
        onDone: (dynamic value) => setState(() {
          _bloodGroup = value;
          print(_bloodGroup);
        }),
      ),
    );
  }

  Widget _getIPSCardPassword() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Password"),
      value: IpsValue(_password ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Password",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _password,
        onDone: (dynamic value) => setState(() {
          _password = value;
          print(_password);
        }),
      ),
    );
  }

  Widget _getIPSCardMailId() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Mail Id"),
      value: IpsValue(mailid ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "MailId",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _fullName,
        onDone: (dynamic value) => setState(() {
          mailid = value;
          print(mailid);
        }),
      ),
    );
  }

  Widget _getIPSCardMobileNumber() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Mobile Number"),
      value: IpsValue(_mobileNumber ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Mobile Number",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _mobileNumber,
        onDone: (dynamic value) => setState(() {
          _mobileNumber = value;
          print(_mobileNumber);
        }),
      ),
    );
  }

  Widget _getIPSCardSmsNotification() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Sms Notification"),
      value: IpsValue(_smsNotification ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Type true if u want to enable else type false",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _smsNotification,
        onDone: (dynamic value) => setState(() {
          _smsNotification = value;
          print(_smsNotification);
        }),
      ),
    );
  }

  Widget _getIPSCardMailNotification() {
    return IpsCard(
//      color: Colors.red,
      label: IpsLabel("Mail Notification"),
      value: IpsValue(_mailNotification ?? "Touch to edit..."),
      icon: IpsIcon(FeatherIcons.edit3),
      error: IpsError(_errors['name']),
      onClick: () => InputSheet(
        context,
        label: "Type true if u want to enable else type false",
        cancelText: "Cancel",
        doneText: "Confirm",
      ).text(
        placeholder: "Type here...",
        value: _mailNotification,
        onDone: (dynamic value) => setState(() {
          _mailNotification = value;
          print(_mailNotification);
        }),
      ),
    );
  }

  _getUpdateSuccessAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Updated Successfully",
      desc: "Updated user Succesfully",
      buttons: [
        DialogButton(
          child: Text(
            "Okay!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnLoginPage(mailid: mailid)),
          ),
          width: 120,
        )
      ],
    ).show();
  }

  _getUpdateFailAlert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Failed to Update Details",
      desc: "Sorry, we are unable to update your details. Please try later.",
      buttons: [
        DialogButton(
          child: Text(
            "Okay!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
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
          updateUserRequest = new UpdateUserRequest();
          updateUserRequest.bloodGroup = _bloodGroup;
          updateUserRequest.mailNotification = _mailNotification;
          updateUserRequest.mailid = mailid;
          updateUserRequest.mobileNumber = _mobileNumber;
          updateUserRequest.smsNotification = _smsNotification;
          updateUserRequest.fullName = _fullName;
          updateUserRequest.city = userDetailsMap['city'];
          updateUserRequest.country = userDetailsMap['country'];
          updateUserRequest.district = userDetailsMap['district'];
          updateUserRequest.state = userDetailsMap['state'];
          updateUserRequest.town = userDetailsMap['town'];
          updateUserRequest.pincode = userDetailsMap['pincode'];
          updateUserRequest.password = userDetailsMap['password'];

          http.Response response = await settingsScreenService
              .updateUserDetails(mailid, updateUserRequest);

          print(response.statusCode);
          if (response.statusCode == 200) {
            Map<String, dynamic> data = json.decode(response.body);
            if (data['status'] == null) {
              print(data['error']);
              _getUpdateFailAlert();
            } else {
              print(data['status']);
              _getUpdateSuccessAlert();
            }
          } else {
            print("Please try again Later");
            _getUpdateFailAlert();
          }
        },
        child: Text("Submit", textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DonorRequestPage(mailid: mailid)),
              );
            },
          )
        ],
        title: Text('Settings'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _getIPSCardName(),
            _getIPSCardMobileNumber(),
            _getIPSCardMailId(),
            _getIPSCardPassword(),
            _getIPSCardBloodGroup(),
            _getIPSCardSmsNotification(),
            _getIPSCardMailNotification(),
            _getRegisterButton()
          ],
        ),
      ),
    );
  }
}
