import 'package:flutter/material.dart';

class FactsPage extends StatefulWidget {
  FactsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FactsPageState createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facts Page'),
        backgroundColor: Colors.redAccent,
        brightness: Brightness.dark,
        centerTitle: true,
      ),
    );
  }
}
