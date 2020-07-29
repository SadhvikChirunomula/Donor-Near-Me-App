import 'dart:convert';

import 'package:dnmui/screens/UserNotfiyPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'DonorListPage.dart';
import 'NoDonorAvailablePage.dart';
import 'SettingsPage.dart';

class DonorRequestPage extends StatefulWidget {
  final String mailid;

  DonorRequestPage({Key key, @required this.mailid}) : super(key: key);

  @override
  _DonorRequestPageState createState() => _DonorRequestPageState(mailid);
}

class _DonorRequestPageState extends State<DonorRequestPage> {
  String mailid;
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
  List<Map> donorList = [];

  _DonorRequestPageState(this.mailid);
  TextEditingController messageFieldController = new TextEditingController();

  Widget _messageBox(){
    return Container(
        width: double.infinity,
        child: TextField(
          controller: messageFieldController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Message",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
    var stateField = Container(
      width: double.infinity,
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
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
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
      child: SearchableDropdown.single(
        isExpanded: true,
        value: district,
        hint: Text('District'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
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
      child: SearchableDropdown.single(
        isExpanded: true,
        value: city,
        hint: Text('City'),
        icon: Icon(Icons.keyboard_arrow_down),
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
    final townField = Container(
      width: double.infinity,
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
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) async {
          var response =
              await http.get('http://35.238.212.200:8080/getlist/bloodgroups');
          Map<String, dynamic> data = json.decode(response.body);
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
    final bloodGroupField = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 0.50),
      ),
      child: SearchableDropdown.single(
        isExpanded: true,
        value: bloodGroup,
        hint: Text('Blood Group'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) {
          bloodGroup = '';
          setState(() {
            bloodGroup = newValue;
            print(bloodGroup);
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
    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print('http://35.238.212.200:8080/getdonors/available?country=' +
              country +
              '&state=' +
              state +
              '&district=' +
              district +
              '&city=' +
              city +
              '&bloodgroup=' +
              bloodGroup +
              '&town=' +
              town);
          var response = await http.get(
              'http://35.238.212.200:8080/getdonors/available?country=' +
                  country +
                  '&state=' +
                  state +
                  '&district=' +
                  district +
                  '&city=' +
                  city +
                  '&bloodgroup=' +
                  bloodGroup +
                  '&town=' +
                  town);
          Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            var jsonList = data['donorsList'];
            donorList = [];
            for (Map x in jsonList) {
              donorList.add(x);
            }
            print(donorList);
          });
          print(donorList.length);
          if (donorList.length == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoDonorAvailablePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DonorListPage(donorList: donorList, mailid: mailid)),
            );
          }
        },
        child: Text(
          "Search",
          textAlign: TextAlign.center,
        ),
      ),
    );
    final notificationsButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          String baseUrl =
              "http://35.238.212.200:8080/getbloodrequests?mailid=" + mailid;
          final response = await http.get(baseUrl);
          Map<String, dynamic> data = json.decode(response.body);
          var jsonList = data['requestsList'];
          List<Map> bloodRequestsList = [];
          for (Map x in jsonList) {
            print(bloodRequestsList);
            bloodRequestsList.add(x);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserNotifyPage(mailid: mailid, bloodRequestsList: bloodRequestsList)),
          );
        },
        child: Text(
          "Blood Requests",
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            )
          ],
          title: Text('Donor Request Page'),
          backgroundColor: Colors.redAccent,
          brightness: Brightness.dark,
          centerTitle: true,
//        leading: Icon(Icons.menu),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.red[100],
              Colors.red[50],
            ])),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text("Hello User " + mailid,style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10.0),
                  notificationsButon,
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
                  searchButon,
                ],
              ),
            ))));
  }
}
