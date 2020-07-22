import 'package:flutter/material.dart';

class PostContactUsPage extends StatefulWidget {
  PostContactUsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PostContactUsPageState createState() => _PostContactUsPageState();
}

class _PostContactUsPageState extends State<PostContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
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
                  Text('We have recieved your Request. We will reach you shortly. \n Thank You',textAlign: TextAlign.center)
                ],
              ),
            )
        ),
      ),
    );
  }
}
