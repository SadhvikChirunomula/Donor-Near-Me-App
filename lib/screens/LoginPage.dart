import 'package:contactus/contactus.dart';
import 'package:dnmui/models/LoginScreen/AuthenticateRequest.dart';
import 'package:dnmui/models/LoginScreen/UpdateFcmTokenRequest.dart';
import 'package:dnmui/screens/RegisterPage.dart';
import 'file:///F:/dnmuiapp/DonorNearMeApp/lib/services/LoginScreenService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_share/flutter_share.dart';

import 'OnLoginPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController emailFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();
  FirebaseMessaging _firebaseMessaging ;
  String error = '';
  String fcmToken= '';
  bool _passwordVisible = false;

  LoginScreenService loginScreenService = new LoginScreenService();
  AuthenticateModel authenticateModel;
  UpdateFcmTokenRequest updateFcmTokenRequest;
  
  Widget _appOwnerDetails() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: ContactUs(
            logo: AssetImage('images/crop.jpg'),
            email: 'adoshi26.ad@gmail.com',
            companyName: 'Abhishek Doshi',
            phoneNumber: '+91123456789',
            website: 'https://abhishekdoshi.godaddysites.com',
            githubUserName: 'AbhishekDoshi26',
            linkedinURL:
                'https://www.linkedin.com/in/abhishek-doshi-520983199/',
            tagLine: 'Flutter Developer',
            twitterHandle: 'AbhishekDoshi26'),
      ),
    );
  }

  Widget _getEmailField() {
    return TextField(
      obscureText: false,
      controller: emailFieldController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget _getPasswordField() {
    return TextField(
        obscureText: !_passwordVisible,
        //This will obscure text dynamically
        controller: passwordFieldController,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )));
  }

  Widget _getLoginButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          authenticateModel = new AuthenticateModel();
          updateFcmTokenRequest = new UpdateFcmTokenRequest();
          authenticateModel.mailid = emailFieldController.text;
          authenticateModel.password = passwordFieldController.text;
          Map<String, dynamic> data = await loginScreenService.authenticateApi(authenticateModel);
          if (data['error'] == null) {
            _firebaseRegister();
            _updateTokenInDb(updateFcmTokenRequest);
            setState(() {
              error = '';
            });
            print("User mailid : " + emailFieldController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OnLoginPage(mailid: emailFieldController.text)),
            );
          } else {
            setState(() {
              error = data['error'];
            });
            print(data['error']);
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register Here',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Donor Near Me',
        text: 'Click on the URL below to download the App',
        linkUrl: 'http://donornearme.com/',
        chooserTitle: 'Find a blood donor near you!');
  }

  _firebaseRegister() {
    _firebaseMessaging = new FirebaseMessaging();
    setState(() {
      _firebaseMessaging.getToken().then((token) => fcmToken = token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Welcome to Donor Near Me'),
          backgroundColor: Colors.redAccent,
          brightness: Brightness.dark,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                share();
              },
            )
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
//          color: Colors.greenAccent
//            gradient: LinearGradient(colors: [
//          Colors.red[200],
//          Colors.red[50],
//          Colors.red[200],
//        ])
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(height: 10.0),
              _getEmailField(),
              SizedBox(height: 25.0),
              _getPasswordField(),
              SizedBox(
                  child: Text(
                error,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10.0,
              ),
              _getLoginButton(),
              SizedBox(
                height: 15.0,
              ),
              _createAccountLabel(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        )),
      ),
    );
  }

  void _updateTokenInDb(UpdateFcmTokenRequest updateFcmTokenRequest) {
    Future<Map<String, dynamic>> data =  loginScreenService.updateFcmToken(updateFcmTokenRequest);
    print(data);
  }
}
