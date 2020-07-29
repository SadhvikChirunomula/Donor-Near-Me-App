import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'AskForLoginOrSignUp.dart';

class DonorListPage extends StatefulWidget {
  final List<Map> donorList;
  final String mailid;

  @override
  DonorListPage({Key key, @required this.donorList, this.mailid})
      : super(key: key);

  @override
  _DonorListPageState createState() => _DonorListPageState(donorList, mailid);
}

class _DonorListPageState extends State<DonorListPage> {
  _DonorListPageState(this.donorList, this.mailid);

  TextEditingController messageFieldController = new TextEditingController();
  String message = '';
  List<Map> donorList;
  String mailid;
  bool toggle = true;
  bool messageSubmitStatus = false;
  List<int> iList = [0, 0, 0, 0, 0, 0];

  Widget getPostNotifyButton(int i) {
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

  String _getRequestBloodMessage() {
    return "Hi, need blood immediatly..";
  }

  Widget getNotifyButton(int i) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
//        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print(donorList[i]);
          http.Response notificationResponse = await http.post(
              'https://fcm.googleapis.com/fcm/send',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization':
                    'key=AAAA2XVt3bQ:APA91bGj9EPpcVmG4Q0ZDJ7EdqBrHWlVi7PSiN_SlSt_15ywGcLj6GIOVlseYujhzESj2TlLglZKpjFp1n4B3AsrehZMZgLYZ8FVcZnglRiJmRiQNazHGmQrmSZjFLOsZDuae-HJZDo-'
              },
              body: '''{
                "notification": {
                  "body": "Someone Around You Need Blood",
                  "title": "Need Blood"
                },
                "priority": "high",
                "data": {
                  "click_action": "FLUTTER_NOTIFICATION_CLICK",
                  "id": "1",
                  "status": "done"
                },
                "to": "cufxOXvkp-4:APA91bFYTAw6VcPL_LD-oPDKMy52AQ4COxuX3d_J3M2_pPTB7OBzUiXovKdQDff7sXWhDC2boiOXU9QfcDH_T9BxXgQXDfNgBqugfElws3xntsgzykWfTQotBFz44-0i0U1Y45WtaBlV"
              }''');

          http.Response dbResponse =
              await http.post('http://35.238.212.200:8080/donorrequest',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'donorId': donorList[i]['mailid'],
                    'message':
                        message == '' ? _getRequestBloodMessage() : message,
                    'receipentId': mailid,
                  }));
          setState(() {
            iList[i] = 1;
          });
        },
        child: Text("Notify Donor", textAlign: TextAlign.center),
      ),
    );
  }

  Widget _messageBox() {
    return Container(
        width: double.infinity,
        child: TextField(
          controller: messageFieldController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Message",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _submitMessageButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              clipBehavior: Clip.antiAlias,
              // Add This
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                setState(() {
                  messageSubmitStatus = true;
                  message = messageFieldController.text;
                });
              },
              child: Text(
                "Submit Message",
                textAlign: TextAlign.center,
              ),
            )));
  }

  Widget _submittedMessageButton() {
    return SizedBox(
        width: 5,
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
//              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: null,
              child: Text(
                "Submitted Message",
                textAlign: TextAlign.center,
              ),
            )));
  }

  _donorListPageInfo(context) {
    Alert(
            context: context,
            title: "About Donors Available Screen",
            desc: "Here user can notify donors by clicking on Notify Donor Button"
    )
        .show();
  }

  @override
  Widget build(BuildContext context) {
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
                child: iList[i] == 0
                    ? getNotifyButton(i)
                    : getPostNotifyButton(i))),
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
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              messageSubmitStatus == true
                  ? _getMessageSubmittedText()
                  : _messageBox(),
              SizedBox(
                  width: 10,
                  child: messageSubmitStatus == true
                      ? doNothing()
                      : _submitMessageButton()),
              SizedBox(height: 10),
              Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: 2, color: Colors.red),
                    outside: BorderSide(width: 3, color: Colors.black)),
                children: forWidget(donorList),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
              child: Icon(
                Icons.info_outline,
                size: 30,
              ),
              onPressed: () => _donorListPageInfo(context)
          ),
        ));
  }

  printIndex(int i) {
    print(i);
  }

  List<int> getIndexList(List<Map> donorList) {
    List<int> indexList = [];
    for (int i = 0; i < donorList.length; i++) {
      indexList.add(0);
    }
  }

  doNothing() {}

  _getMessageSubmittedText() {
    Text(
        "Message that is submitted will be sent the donor as notification. If u want to change method..please go to the previous page and search again..");
  }
}
