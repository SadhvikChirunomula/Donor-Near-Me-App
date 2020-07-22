import 'package:flutter/material.dart';

import 'DonorRequestPage.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon : Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonorRequestPage()),
              );
            },
          )
        ],
        title: Text('Settings'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
    );
  }
}