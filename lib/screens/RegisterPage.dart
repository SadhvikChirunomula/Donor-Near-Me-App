import 'dart:convert';

import 'package:dnmui/screens/OtpVerifyPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String country;
  String state;
  String district;
  String city;
  String town;
  String bloodGroup;
  List<String> countriesList = [];
  List<String> statesList = [];
  List<String> districtList = [];
  List<String> citiesList = [];
  List<String> townsList = [];
  List<String> bloodGroupsList = [];
  TextEditingController pincodeFieldController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountriesList(); // When you first open the home screen then this method is run for the first time too
  }

  Future<void> getCountriesList() async {
    String baseUrl = "http://35.238.212.200:8080/getlist/countries";
    final response = await http.get(baseUrl);
    final Map<String, dynamic> data = json.decode(response.body);
//    print(data['countriesList']['country']);
    var jsonList = data['countriesList']['country'];
    countriesList = [];
    for (String x in jsonList) {
      countriesList.add(x);
    }
//    print(countriesList);
  }

  @override
  Widget build(BuildContext context) {
    final fullNameField = Container(
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
    final emailField = Container(
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
    final passwordField = Container(
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
    final mobileNumberField = Container(
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
    final countryField = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('Country'),
        value: country,
        dropdownColor: Colors.red[100],
        icon: Icon(Icons.keyboard_arrow_down),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        underline: SizedBox(),
        onChanged: (String newValue) async {
          var response = await http.get(
              'http://35.238.212.200:8080/getlist/states?country=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
//          print(data['statesList']['states']);
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
        items: <String>['India'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    final stateField = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: state,
        hint: Text('State'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
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
    final districtField = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        value: district,
        hint: Text('District'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response = await http.get(
              'http://35.238.212.200:8080/getlist/cities?district=' + newValue);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            district = newValue;
            var jsonList = data['citiesList']['city'];
            citiesList = [];
            for (String x in jsonList) {
              citiesList.add(x);
            }
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
    final cityField = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        value: city,
        hint: Text('City'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
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
    final townField = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: town,
        hint: Text('Town'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response =
              await http.get('http://35.238.212.200:8080/getlist/bloodgroups');
          Map<String, dynamic> data = json.decode(response.body);
          bloodGroupsList = [];
          setState(() {
            town = newValue;
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
    final bloodGroupField = Container(
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
    final pincodeField = Container(
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

    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          String userDetailsJson = jsonEncode(<String, String>{
            'bloodgroup': bloodGroup,
            'city': city,
            'country': country,
            'district': district,
            'mail_notification': 'true',
            'mailid': emailFieldController.text,
            'password': passwordFieldController.text,
            'phonenumber': mobileNumberFieldController.text,
            'pincode': pincodeFieldController.text,
            'sms_notification': 'true',
            'state': state,
            'town': town,
            'username': fullNameFieldController.text,
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
            print("Taking you to OTP Page");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpVerifyPage(userDetails: userDetailsJson)),
            );
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
              fullNameField,
              SizedBox(height: 10.0),
              emailField,
              SizedBox(height: 10.0),
              passwordField,
              SizedBox(height: 10.0),
              mobileNumberField,
              SizedBox(height: 10.0),
              countryField,
              SizedBox(height: 10.0),
              stateField,
              SizedBox(height: 10.0),
              districtField,
              SizedBox(height: 10.0),
              cityField,
              SizedBox(height: 10.0),
              townField,
              SizedBox(height: 10.0),
              bloodGroupField,
              SizedBox(height: 10.0),
              pincodeField,
              SizedBox(height: 10.0),
              registerButon,
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
