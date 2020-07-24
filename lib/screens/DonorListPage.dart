import 'dart:convert';

import 'package:flutter/material.dart';
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
  bool toggle = true;

  _DonorListPageState(this.donorList);

  @override
  Widget build(BuildContext context) {
    final String jsonSample = jsonEncode(donorList);
    var json = jsonDecode(jsonSample);

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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: toggle
                  ? Column(
                      children: [
                        JsonTable(
                          json,
//                          showColumnToggle: true,
                          allowRowHighlight: true,
                          rowHighlightColor:
                              Colors.yellow[500].withOpacity(0.7),
                          paginationRowCount: 10,
                          onRowSelect: (index, map) {
                            print(index);
                            print(map);
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                            "List of Donors Available.")
                      ],
                    )
                  : Center(
                      child: Text(getPrettyJSONString(jsonSample)),
                    ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.grid_on),
          onPressed: () {
            setState(
              () {
                toggle = !toggle;
              },
            );
          }),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}
