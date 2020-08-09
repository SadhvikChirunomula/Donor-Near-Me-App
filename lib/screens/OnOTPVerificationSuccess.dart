import 'dart:convert';

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
//import FirebaseInstanceID;

class OnOTPVerificationSuccessPage extends StatefulWidget {
  OnOTPVerificationSuccessPage({Key key, this.userDetailsJson}) : super(key: key);

  String userDetailsJson;

  @override
  _OnOTPVerificationSuccessPageState createState() => _OnOTPVerificationSuccessPageState(userDetailsJson);
}

class _OnOTPVerificationSuccessPageState extends State<OnOTPVerificationSuccessPage> {
  String userDetailsJson;
  _OnOTPVerificationSuccessPageState(this.userDetailsJson);
  Map<String,dynamic> userDetailsMap;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String country;
  String state;
  String district;
  String city;
  String town;
  List<String> countriesList = [];
  List<String> statesList = [];
  List<String> districtList = [];
  List<String> citiesList = [];
  List<String> townsList = [];
  TextEditingController pincodeFieldController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountriesList();
    userDetailsMap = jsonDecode(userDetailsJson);
  }

  Future<void> getCountriesList() async {
    String baseUrl = "http://35.238.212.200:8080/getlist/countries";
    final response = await http.get(baseUrl);
    final Map<String, dynamic> data = json.decode(response.body);
    var jsonList = data['countriesList']['country'];
    countriesList = [];
    setState(() {
      for (String x in jsonList) {
        countriesList.add(x);
      }
    });
  }

  Widget _getCountryField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: SearchableDropdown.single(
        isExpanded: true,
        hint: Text('Country'),
        searchHint: "Please Select Your Country",
        value: country,
        iconEnabledColor : Colors.blue,
        iconDisabledColor: Colors.black,
        dialogBox: true,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response = await http.get(
              'http://35.238.212.200:8080/getlist/states?country=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            country = newValue;
            //Todo make api call
            var jsonList = data['statesList']['states'];
            statesList = [];
            for (String x in jsonList) {
              statesList.add(x);
            }
          });
        },
        items: countriesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getStateField(List<String> statesList) {
    return Container(
//      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: SearchableDropdown.single(
        isExpanded: true,
        value: state,
        hint: Text('State'),
        searchHint: "Please Select Your State",
//        disabledHint: "Please select Country First",
        icon: Icon(Icons.keyboard_arrow_down),
        iconEnabledColor : Colors.blue,
        iconDisabledColor: Colors.black,
        iconSize: 24,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response = await http.get(
              'http://35.238.212.200:8080/getlist/districts?state=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            state = newValue;
            districtList = [];
            var jsonList = data['districtsList']['districts'];
            for (String x in jsonList) {
              districtList.add(x);
            }
          });
        },
        items: statesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getDistrictField(List<String> districtsList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
//      width: double.infinity,
      child: SearchableDropdown.single(
        isExpanded: true,
        value: district,
        hint: Text('District'),
        searchHint: "Please Select Your District",
//        disabledHint: "Please select State First",
        icon: Icon(Icons.keyboard_arrow_down),
        iconEnabledColor : Colors.blue,
        displayClearIcon: false,
        iconDisabledColor: Colors.black,
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response = await http.get(
              'http://35.238.212.200:8080/getlist/cities?district=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            district = newValue;
            var jsonList = data['citiesList']['city'];
            List<String> citiesListtemp = [];
            for (String x in jsonList) {
              citiesListtemp.add(x);
            }
            citiesList = citiesListtemp;
          });
        },
        items: districtList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getCityField(List<String> citiesList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
//      width: double.infinity,
      child: SearchableDropdown.single(
        isExpanded: true,
        value: city,
        hint: Text('City'),
        searchHint: "Please Select Your City",
//        disabledHint: "Please select District First",
        icon: Icon(Icons.keyboard_arrow_down),
        iconEnabledColor : Colors.blue,
        iconDisabledColor: Colors.black,
        displayClearIcon: false,
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response = await http
              .get('http://35.238.212.200:8080/getlist/towns?city=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            city = newValue;
            townsList = [];
            var jsonList = data['townsList']['town'];
            for (String x in jsonList) {
              townsList.add(x);
            }
          });
        },
        items: citiesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getTownField(List<String> townsList) {
    return Container(
//      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: SearchableDropdown.single(
        isExpanded: true,
        value: town,
        hint: Text('Town'),
        searchHint: "Please Select Your Town",
//        disabledHint: "Please select City First",
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        iconEnabledColor : Colors.blue,
        iconDisabledColor: Colors.black,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response =
          await http.get('http://35.238.212.200:8080/getlist/bloodgroups');
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            town = newValue;
          });
        },
        items: townsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _getPincodeField(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: pincodeFieldController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Pincode",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  _addUserToDb(Map<String, dynamic> userDetailsMap) async {
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnRegistrationSuccess()),
      );
    } else {
      print('Failed to add User');
    }

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
          String userDetailsJson = jsonEncode(<String, String>{
            'bloodgroup': userDetailsMap['bloodgroup'],
            'city': city,
            'country': country,
            'district': district,
            'mail_notification': 'true',
            'mailid': userDetailsMap['mailid'],
            'password': userDetailsMap['password'],
            'phonenumber': userDetailsMap['phonenumber'],
            'pincode': pincodeFieldController.text,
            'sms_notification': 'true',
            'state': state,
            'town': town,
            'username': userDetailsMap['username'],
            'fcmtoken': userDetailsMap['fcmtoken']
          });
          print(userDetailsJson);
          userDetailsMap = jsonDecode(userDetailsJson);
          _addUserToDb(userDetailsMap);
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Enter your location Details'),
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
                  SizedBox(height: 10.0),
                  _getCountryField(),
                  SizedBox(height: 10.0),
                  _getStateField(statesList),
                  SizedBox(height: 10.0),
                  _getDistrictField(districtList),
                  SizedBox(height: 10.0),
                  _getCityField(citiesList),
                  SizedBox(height: 10.0),
                  _getTownField(townsList),
                  SizedBox(height: 10.0),
                  _getPincodeField(),
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
