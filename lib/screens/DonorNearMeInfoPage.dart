import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/material.dart';

import 'AskForLoginOrSignUp.dart';

class DonorNearMeInfoPage extends StatefulWidget {
  DonorNearMeInfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DonorNearMeInfoPageState createState() => _DonorNearMeInfoPageState();
}

class _DonorNearMeInfoPageState extends State<DonorNearMeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('About Us'),
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
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red[100],
          Colors.white,
          Colors.red[50],
        ])),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                'This is Info Page. Here you can find facts about Donor Near Me',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: Colors.black, fontFamily: 'Open Sans', fontSize: 20),
              )
            ],
          ),
        )),
      ),
    );
  }
}
