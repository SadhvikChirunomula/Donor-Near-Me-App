import 'package:flutter/material.dart';

class NoDonorAvailablePage extends StatefulWidget {
  NoDonorAvailablePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NoDonorAvailablePageState createState() => _NoDonorAvailablePageState();
}

class _NoDonorAvailablePageState extends State<NoDonorAvailablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Donor Available'),
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
                    Text('We are sorry, but we dont have any users in the location Specified. We really hope that we help you better.')
                  ],
                ),
              )
          ),
      ),
    );
  }
}
