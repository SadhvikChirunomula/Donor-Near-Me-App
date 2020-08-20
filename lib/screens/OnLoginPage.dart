import 'package:badges/badges.dart';
import 'package:dnmui/models/OnLoginScreenModel/GetBloodRequestListRequest.dart';
import 'package:dnmui/models/OnLoginScreenModel/SubmitUserReviewRequest.dart';
import 'package:dnmui/screens/ContactUsPage.dart';
import 'package:dnmui/screens/DonorRequestPage.dart';
import 'package:dnmui/screens/LoginPage.dart';
import 'package:dnmui/services/OnLoginScreenService.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'FactsPage.dart';
import 'SettingsPage.dart';
import 'UserNotfiyPage.dart';

class OnLoginPage extends StatefulWidget {
  final String mailid;

  OnLoginPage({Key key, @required this.mailid}) : super(key: key);

  @override
  _OnLoginPageState createState() => _OnLoginPageState(mailid);
}

class _OnLoginPageState extends State<OnLoginPage> {
  String mailid;
  OnLoginScreenService onLoginScreenService;
  String userRating;
  GetBloodRequestListRequest getBloodRequestListRequest;
  _OnLoginPageState(this.mailid);

  List<Map> bloodRequestsList = [];

  Future<List<Map>> _getBloodRequestsList(String mailid) async {
    onLoginScreenService = new OnLoginScreenService();
    getBloodRequestListRequest = new GetBloodRequestListRequest();
    getBloodRequestListRequest.mailid = mailid;
    Map<String, dynamic> data = await onLoginScreenService
        .getBloodRequestsList(getBloodRequestListRequest);
    ;
    var jsonList = data['requestsList'];
    List<Map> tempList = [];
    for (Map x in jsonList) {
      tempList.add(x);
    }
    print(tempList);
    return tempList;
  }

  Widget _notificationBadge() {
    return Badge(
      position: BadgePosition.topRight(top: 0, right: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        '10',
        style: TextStyle(color: Colors.white),
      ),
      child: _getBloodRequestsButton(mailid),
    );
  }

  Widget _getRequestBloodButton(String mailid) {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
//          minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                print(mailid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonorRequestPage(mailid: mailid)),
                );
              },
              child: Text("Request a Donor",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
  }

  Widget _getContactUsButton() {
    return Container(
        height: 75.0,
        width: 75.0,
        child: FloatingActionButton(
          child: Text("Contact Us",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
          onPressed: () {
            print("Taking you to Contact Us Page");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
            );
          },
        ));
  }

  Widget _getFactsButton() {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FactsPage()),
                );
              },
              child: Text("Get Facts",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
  }

  Widget _getBloodRequestsButton(String mailid) {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
//          minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                bloodRequestsList = await _getBloodRequestsList(mailid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserNotifyPage(
                          mailid: mailid,
                          bloodRequestsList: bloodRequestsList)),
                );
              },
              child: Text("Blood Request Near You",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
            )));
  }

  Widget _getHelloUserText(String mailid) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.orange,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 42.0, vertical: 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hello, " + mailid,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    Text(
                      "We are always happy to help you!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(mailid: mailid)),
                  );
                },
                child: Container(
                  child: new IconButton(
                    color: Colors.white,
                    icon: new Icon(Icons.settings),
                  ),
                )),
            GestureDetector(
                onTap: () async {
                  print("Logging Out");
                  clearSharedPreferences();
                  _reviewAlert(mailid);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LoginPage()),
                  // );
                },
                child: Container(
                  child: IconButton(
                    color: Colors.white,
                    icon: new Icon(Icons.exit_to_app),
                  ),
                ))
          ],
          title: Text('Welcome Donor'),
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
          //          centerTitle: true
        ),
        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
            ])),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _getHelloUserText(mailid),
                  SizedBox(height: 60.0),
                  _getRequestBloodButton(mailid),
                  SizedBox(height: 40.0),
                  _getBloodRequestsButton(mailid),
                  SizedBox(height: 40.0),
                  _getFactsButton(),
                  SizedBox(height: 40.0),
                  //                  _notificationBadge()
                ],
              ),
            )),
        floatingActionButton: _getContactUsButton());
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isUserLoggedIn', false);
  }

  Widget _getRatingBar() {
    return RatingBar(
        initialRating: 5,
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            case 1:
              return Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
              );
            case 2:
              return Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
              );
            case 3:
              return Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
              );
            case 4:
              return Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
          }
        },
        onRatingUpdate: (rating) {
          setState(() {
            userRating = rating.toString().substring(0, 1);
          });
          print(rating);
        });
  }

  TextEditingController commentController = new TextEditingController();

  Widget _getCommentBox() {
    return Container(
        width: double.infinity,
        child: TextField(
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black),
          controller: commentController,
          obscureText: false,
          decoration: InputDecoration(
              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Pls Share you comment..",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  Widget _getReviewSubmitBotton() {
    return Container(
        width: 30,
        height: 60,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: new Text("hello World"));
  }

  _reviewAlert(String mailid) {
    Alert(
        context: context,
        title: "Rate your experience",
        content: Column(
          children: <Widget>[
            _getRatingBar(),
            SizedBox(height: 15.0),
            _getCommentBox(),
          ],
        ),
        buttons: [_getReviewSubmitButtonTest(mailid)]).show();
  }

  _getReviewSubmitButtonTest(String mailid) {
    SubmitUserReviewRequest submitUserReviewRequest =
        new SubmitUserReviewRequest();
    onLoginScreenService = new OnLoginScreenService();
    return DialogButton(
      color: Colors.red,
      onPressed: () {
        submitUserReviewRequest.mailId = mailid;
        submitUserReviewRequest.stars = userRating;
        if (userRating == 0) {
          submitUserReviewRequest.stars = "3";
        }
        submitUserReviewRequest.comment = commentController.text;
        if (commentController.text == "") {
          submitUserReviewRequest.comment = "No comment Provided";
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        onLoginScreenService.submitUserReview(submitUserReviewRequest);
      },
      child: Text(
        "Submit and Logout",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
