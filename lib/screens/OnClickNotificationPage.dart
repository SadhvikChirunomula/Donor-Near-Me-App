import 'package:flutter/material.dart';

import 'DonorRequestPage.dart';

class OnNotificationClickPage extends StatefulWidget {
  OnNotificationClickPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnNotificationClickPageState createState() => _OnNotificationClickPageState();
}

class _OnNotificationClickPageState extends State<OnNotificationClickPage> {
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
                MaterialPageRoute(builder: (context) => DonorRequestPage(mailid :"1234")),
              );
            },
          )
        ],
        title: Text('OnNotificationClick'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
    );
  }
}
