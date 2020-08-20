import 'dart:convert';

import 'package:dnmui/models/OnOtpVerificationSuccessModel/AddUserRequest.dart';
import 'package:dnmui/models/OnOtpVerificationSuccessModel/GetCitiesListRequest.dart';
import 'package:dnmui/models/OnOtpVerificationSuccessModel/GetDistrictsListRequest.dart';
import 'package:dnmui/models/OnOtpVerificationSuccessModel/GetPincodeRequest.dart';
import 'package:dnmui/models/OnOtpVerificationSuccessModel/GetStatesListRequest.dart';
import 'package:dnmui/models/OnOtpVerificationSuccessModel/GetTownsListRequest.dart';
import 'package:dnmui/screens/LoginPage.dart';
import 'package:dnmui/services/OnOtpVerificationSuccessService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'AskForLoginOrSignUp.dart';
import 'RegistrationSuccessSplashScreen.dart';
//import FirebaseInstanceID;

class OnOTPVerificationSuccessPage extends StatefulWidget {
  OnOTPVerificationSuccessPage({Key key, this.userDetailsJson})
      : super(key: key);

  String userDetailsJson;

  @override
  _OnOTPVerificationSuccessPageState createState() =>
      _OnOTPVerificationSuccessPageState(userDetailsJson);
}

class _OnOTPVerificationSuccessPageState
    extends State<OnOTPVerificationSuccessPage> {
  String userDetailsJson;

  _OnOTPVerificationSuccessPageState(this.userDetailsJson);

  Map<String, dynamic> userDetailsMap;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String country;
  String state;
  String district;
  String city;
  String town;
  String pincode;
  List<String> countriesList = ['India'];
  List<String> statesList = [];
  List<String> districtList = [];
  List<String> citiesList = [];
  List<String> townsList = [];
  List<String> bloodGroupsList = [];
  OnOtpVerificationSuccessService onOtpVerificationSuccessService =
      new OnOtpVerificationSuccessService();
  GetStatesListRequest getStatesListRequest;
  GetDistrictsListRequest getDistrictsListRequest;
  GetCitiesListRequest getCitiesListRequest;
  GetTownsListRequest getTownsListRequest;
  GetPincodeRequest getPincodeRequest;
  AddUserRequest addUserRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetailsMap = jsonDecode(userDetailsJson);
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
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.black,
        dialogBox: true,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          getStatesListRequest = new GetStatesListRequest();
          getStatesListRequest.country = newValue;
          Map<String, dynamic> data = await onOtpVerificationSuccessService
              .getStatesList(getStatesListRequest);
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
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.black,
        iconSize: 24,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          getDistrictsListRequest = new GetDistrictsListRequest();
          getDistrictsListRequest.state = newValue;
          Map<String, dynamic> data = await onOtpVerificationSuccessService
              .getDistrictsList(getDistrictsListRequest);
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
        iconEnabledColor: Colors.blue,
        displayClearIcon: false,
        iconDisabledColor: Colors.black,
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          getCitiesListRequest = new GetCitiesListRequest();
          getCitiesListRequest.district = newValue;
          Map<String, dynamic> data = await onOtpVerificationSuccessService
              .getCitiesList(getCitiesListRequest);
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
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.black,
        displayClearIcon: false,
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          getTownsListRequest = new GetTownsListRequest();
          getTownsListRequest.city = newValue;
          Map<String, dynamic> data = await onOtpVerificationSuccessService
              .getTownsList(getTownsListRequest);
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
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.black,
        displayClearIcon: false,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          Map<String, dynamic> data =
              await onOtpVerificationSuccessService.getBloodGroupsList();
          bloodGroupsList = [];
          setState(() {
            town = newValue;
            bloodGroupsList = [];
            var jsonList = data['bloodGroupsList']['blood_group'];
            for (String x in jsonList) {
              bloodGroupsList.add(x);
            }
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

  Widget _getHelloUserText(String mailid) {
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
                        "Hello, " + mailid,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Please tell us your location Details (Country..then State..District..City..Town). \n These Details are kept confidential.  \n",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _addUserToDb(Map<String, dynamic> userDetailsMap) async {
    addUserRequest = new AddUserRequest();
    addUserRequest.bloodgroup = userDetailsMap['bloodgroup'];
    addUserRequest.city = userDetailsMap['city'];
    addUserRequest.country = userDetailsMap['country'];
    addUserRequest.district = userDetailsMap['district'];
    addUserRequest.mail_notification = userDetailsMap['mail_notification'];
    addUserRequest.mailid = userDetailsMap['mailid'];
    addUserRequest.password = userDetailsMap['password'];
    addUserRequest.phonenumber = userDetailsMap['phonenumber'];
    addUserRequest.pincode = userDetailsMap['pincode'];
    addUserRequest.sms_notification = userDetailsMap['sms_notification'];
    addUserRequest.state = userDetailsMap['state'];
    addUserRequest.town = userDetailsMap['town'];
    addUserRequest.username = userDetailsMap['username'];
    addUserRequest.fcmtoken = userDetailsMap['fcmtoken'];

    Map<String, dynamic> addedData =
        await onOtpVerificationSuccessService.addUserToDb(addUserRequest);
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

  _getPincodeValue() async {
    getPincodeRequest = new GetPincodeRequest();
    getPincodeRequest.state = state;
    getPincodeRequest.district = district;
    getPincodeRequest.country = country;
    getPincodeRequest.city = city;
    Map<String, dynamic> data =
        await onOtpVerificationSuccessService.getPincode(getPincodeRequest);
    setState(() {
      pincode = data['pincode'];
    });
  }

  Widget _getRegisterButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _getPincodeValue();
          String userDetailsJson = jsonEncode(<String, String>{
            'bloodgroup': userDetailsMap['bloodgroup'],
            'city': city,
            'country': country,
            'district': district,
            'mail_notification': 'true',
            'mailid': userDetailsMap['mailid'],
            'password': userDetailsMap['password'],
            'phonenumber': userDetailsMap['phonenumber'],
            'pincode': pincode,
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
        child: Text("Submit",
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            )
          ]),
      body: Container(
        decoration: BoxDecoration(color: Colors.white
//            gradient:
//            LinearGradient(colors: [Colors.red[100], Colors.red[200]])
            ),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getHelloUserText(userDetailsMap['mailid']),
              SizedBox(height: 30.0),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: _getCountryField()),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: _getStateField(statesList),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: _getDistrictField(districtList),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: _getCityField(citiesList),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: _getTownField(townsList),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: _getRegisterButton(),
              ),
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
