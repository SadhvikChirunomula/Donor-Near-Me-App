import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
    );
  }
}
