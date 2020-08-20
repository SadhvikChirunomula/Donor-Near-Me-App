import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Facts Page'),
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
        body: Container(child: Text("Hello WOrld")));
  }
}
