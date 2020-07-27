import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

import 'AskForLoginOrSignUp.dart';

class DonorListPage extends StatefulWidget {
  final List<Map> donorList;

  @override
  DonorListPage({Key key, @required this.donorList}) : super(key: key);

  @override
  _DonorListPageState createState() => _DonorListPageState(donorList);
}

class _DonorListPageState extends State<DonorListPage> {
  _DonorListPageState(this.donorList);

  List<Map> donorList;
  bool toggle = true;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  String buttonState = 'empty';
  List<int> iList= [0,0,0,0,0,0];

  Widget getPostNotifyButton(int i){
    return Material(
//    elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: null,
        child: Text("Notified", textAlign: TextAlign.center),
      ),
    );
  }

  Widget getNotifyButton(int i){
    return Material(
    elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
//        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          print(donorList[i]);
          setState(() {
            iList[i]=1;
          });
        },
        child: Text("Notify Donor", textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    iList = getIndexList(donorList);

    TableRow forEachRowWidget(int i, Map<dynamic, dynamic> donorList) {
      return TableRow(children: [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(
                child: Text(donorList['username'],
                    style: TextStyle(fontSize: 18)))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(
                child:
                    Text(donorList['state'], style: TextStyle(fontSize: 18)))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(
                child: Text(donorList['district'],
                    style: TextStyle(fontSize: 18)))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(
      child: iList[i]==0?getNotifyButton(i):getPostNotifyButton(i))),
      ]);
    }

    List<TableRow> forWidget(List<Map> donorList) {
      List<TableRow> rows = [];
      rows.add(TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text('Full Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)))),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text('District',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)))),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text('State',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)))),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text('Notify Donor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)))),
          ]));
      for (int i = 0; i < donorList.length; i++) {
        rows.add(forEachRowWidget(i, donorList[i]));
      }
      return rows;
    }

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.symmetric(
              inside: BorderSide(width: 2, color: Colors.red),
              outside: BorderSide(width: 3, color: Colors.black)),
          children: forWidget(donorList),
        ),
      ),
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

  printIndex(int i) {
    print(i);
  }

  List<int> getIndexList(List<Map> donorList) {
    List<int> indexList = [];
    for(int i=0;i<donorList.length;i++){
      indexList.add(0);
    }
  }
}
