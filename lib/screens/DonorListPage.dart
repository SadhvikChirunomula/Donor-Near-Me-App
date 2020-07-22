import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';

import 'AskForLoginOrSignUp.dart';



class DonorListPage extends StatefulWidget {
  final List<Map> donorList;

  @override
  DonorListPage({Key key, @required this.donorList}) : super(key: key);

  @override
  _DonorListPageState createState() => _DonorListPageState(donorList);
}

class _DonorListPageState extends State<DonorListPage> {
  List<Map> donorList;
  _DonorListPageState(this.donorList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors Available'),
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
          ]
      ),
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

                    for(Map x in donorList) Text(x['mailid'])
                  ],
                ),
              )
          ),
        ),
    );
  }
}
