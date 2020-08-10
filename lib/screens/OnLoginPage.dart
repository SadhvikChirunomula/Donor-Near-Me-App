import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dnmui/screens/ContactUsPage.dart';
import 'package:dnmui/screens/DonorRequestPage.dart';
import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'FactsPage.dart';
import 'SettingsPage.dart';
import 'UserNotfiyPage.dart';

class OnLoginPage extends StatefulWidget {
  final String mailid;

  OnLoginPage({Key key, @required this.mailid}) : super(key: key);

  @override
  _OnLoginPageState createState() => _OnLoginPageState(mailid);
}

class _OnLoginPageState extends State<OnLoginPage> {
  String mailid;

  _OnLoginPageState(this.mailid);

  List<Map> bloodRequestsList = [];

  Future<List<Map>> _getBloodRequestsList(String mailid) async {
    String baseUrl =
        "http://35.238.212.200:8080/getbloodrequests?mailid=" + mailid;
    final response = await http.get(baseUrl);
    Map<String, dynamic> data = json.decode(response.body);
    var jsonList = data['requestsList'];
    for (Map x in jsonList) {
      print(bloodRequestsList);
      bloodRequestsList.add(x);
    }
    return bloodRequestsList;
  }

  Widget _notificationBadge() {
    return Badge(
      position: BadgePosition.topRight(top: 0, right: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        '10',
        style: TextStyle(color: Colors.white),
      ),
      child: _getBloodRequestsButton(mailid),
    );
  }

  Widget _getRequestBloodButton(String mailid) {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
//          minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                print(mailid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonorRequestPage(mailid: mailid)),
                );
              },
              child: Text("Request a Donor",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
  }

  Widget _getContactUsButton() {
    return Container(
        height: 75.0,
        width: 75.0,
        child: FloatingActionButton(
          child: Text("Contact Us",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
          onPressed: () {
            print("Taking you to Contact Us Page");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
            );
          },
        ));
  }

  Widget _getFactsButton() {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FactsPage()),
                );
              },
              child: Text("Get Facts",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
  }

  Widget _getBloodRequestsButton(String mailid) {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
//          minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                _getBloodRequestsList(mailid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserNotifyPage(
                          mailid: mailid,
                          bloodRequestsList: bloodRequestsList)),
                );
              },
              child: Text("Blood Request Near You",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hello, " + mailid,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    Text(
                      "We are always happy to help you!",
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
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(mailid: mailid)),
                  );
                },
                child: Container(
                  child: new IconButton(
                    color: Colors.white,
                    icon: new Icon(Icons.settings),
                  ),
                )),
            GestureDetector(
                onTap: () {
                  print("Logging Out");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  child: new IconButton(
                    color: Colors.white,
                    icon: new Icon(Icons.exit_to_app),
                  ),
                )
            )
          ],
          title: Text('Welcome Donor'),
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
//          centerTitle: true
        ),
        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
            ])),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _getHelloUserText(mailid),
                  SizedBox(height: 60.0),
                  _getRequestBloodButton(mailid),
                  SizedBox(height: 40.0),
                  _getBloodRequestsButton(mailid),
                  SizedBox(height: 40.0),
                  _getFactsButton(),
                  SizedBox(height: 40.0),
//                  _notificationBadge()
                ],
              ),
            )),
        floatingActionButton: _getContactUsButton());
  }
}
