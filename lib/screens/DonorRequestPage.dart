import 'dart:convert';

import 'package:dnmui/models/DonorRequestScreenModel/GetAvailableDonorsListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetCitiesListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetDistrictsListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetStatesListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetTownsListRequest.dart';
import 'package:dnmui/models/OnLoginScreenModel/GetBloodRequestListRequest.dart';
import 'package:dnmui/services/DonorRequestScreenService.dart';
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

  _DonorRequestPageState(this.mailid);

  String country = '';
  String state = '';
  String district = '';
  String city = '';
  String town = '';
  String bloodGroup = '';
  List<String> countriesList = ['India'];
  List<String> statesList = [];
  List<String> districtList = [];
  List<String> citiesList = [];
  List<String> townsList = [];
  List<String> bloodGroupsList = [];
  List<Map> donorList = [];
  DonorRequestScreenService donorRequestScreenService = new DonorRequestScreenService();
  GetStatesListRequest getStatesListRequest;
  GetDistrictsListRequest getDistrictsListRequest;
  GetCitiesListRequest getCitiesListRequest;
  GetTownsListRequest getTownsListRequest;
  GetAvailableDonorsListRequest getAvailableDonorsListRequest;
  GetBloodRequestListRequest getBloodRequestListRequest;


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
          Map<String, dynamic> data = await donorRequestScreenService.getStatesList(getStatesListRequest);
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
          Map<String, dynamic> data = await donorRequestScreenService.getDistrictsList(getDistrictsListRequest);
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
          Map<String, dynamic> data = await donorRequestScreenService.getCitiesList(getCitiesListRequest);
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
          Map<String, dynamic> data = await donorRequestScreenService.getTownsList(getTownsListRequest);
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
          Map<String, dynamic> data = await donorRequestScreenService.getBloodGroupsList();
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

  Widget _getBloodGroupField(List<String> bloodGroupsList) {
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
        value: bloodGroup,
        hint: Text('Blood Group'),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.black,
        displayClearIcon: false,
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
  }

  Widget _getSearchButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          getAvailableDonorsListRequest = new GetAvailableDonorsListRequest();
          getAvailableDonorsListRequest.town = town;
          getAvailableDonorsListRequest.bloodGroup = bloodGroup;
          getAvailableDonorsListRequest.city = city;
          getAvailableDonorsListRequest.district = district;
          getAvailableDonorsListRequest.state = state;
          getAvailableDonorsListRequest.country = country;
          Map<String, dynamic> data = await donorRequestScreenService.getAvailableDonors(getAvailableDonorsListRequest);
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
                  builder: (context) =>
                      DonorListPage(donorList: donorList, mailid: mailid)),
            );
          }
        },
        child: Text(
          "Search",
          textAlign: TextAlign.center,
        ),
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
                      "Please provide location where you require blood. Please first select Country..then State..District..City..Town. \nBased on the provided location we will give you the details of the donors nearby",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.red[100],
              Colors.orange[200],
            ])),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _getHelloUserText(mailid),
                  SizedBox(height: 20.0),
                  Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: _getCountryField()),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getStateField(statesList),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getDistrictField(districtList),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getCityField(citiesList),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getTownField(townsList),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getBloodGroupField(bloodGroupsList),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: _getSearchButton(),
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            )));
  }
}
