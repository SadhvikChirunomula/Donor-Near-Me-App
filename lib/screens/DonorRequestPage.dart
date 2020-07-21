import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class DonorRequestPage extends StatefulWidget {
  DonorRequestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DonorRequestPageState createState() => _DonorRequestPageState();
}

class _DonorRequestPageState extends State<DonorRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Request Page'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
    );
  }
}
