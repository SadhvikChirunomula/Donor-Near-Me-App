import 'package:dnmui/screens/LoginPage.dart';
import 'package:flutter/material.dart';

import 'AskForLoginOrSignUp.dart';

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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red[100],
            Colors.white,
          ])),
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.red[100],
                  ])),
                  child: SizedBox(
                      child: new Text(
                    "\n WHY SHOULD 'I' DONATE BLOOD \n 1. It saves lives. \n 2. It is not more painful than losing a loved one that you may save by donating. \n 3. Because some day, I may need someone to do the same for me. \n 4. I can’t discover a cure for cancer, but I can help keep someone alive while they are waiting for a cure. \n 5. Because I know too many people who can’t give blood \n 6. It gives donors a medical check at no cost. \n 7. The satisfaction of helping others. \n 8. Blood donation is important because maintaining an adequate blood supply in our community secures blood transfusions for patients. \n",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 18),
                  ))),
              SizedBox(height: 20.0),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.red[100],
                  ])),
                  child: SizedBox(
                      child: new Text(
                    "\n NEED OF BLOOD SUPPLY \n 1. Every 2 seconds some one need blood \n 2. A single burned victim needs 40 units of blood \n 3. A single heart surgery require 6 units of blood \n 4. Car accident need 100 units of blood \n 5. A cancer patient need blood almost every day for his chemotherapy \n 6. In the last 5 years 32% of patients died just cause lack of blood transfusion \n 7. O type is the most required and demanding blood group \n 8. 35% of people have type O+ or O9. 0.4% of people have AB type \n",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 18),
                  ))),
              SizedBox(height: 25.0),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.red[100],
                  ])),
                  child: SizedBox(
                      child: new Text(
                    "\n ABOUT DONOR'S \n 1. The simple reason why donor's donate blood is to safe lives \n 2. Each donation can save 3 lives i.e if you began donation from the age of 18 and donated \n every 90 days until you reached 60, you would have donated 30 gallons of blood, potentially helping save more than 500 lives. \n 3. There is around 5 Cr units required every year but only 2.5 lakhs of units is collected every year \n 4. Blood cannotbe generated. It is only collected from the generous and kind hearted donors. \n",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 18),
                  ))),
              SizedBox(height: 25.0),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.red[100],
                  ])),
                  child: SizedBox(
                      child: new Text(
                    "\n WHAT IS BLOOD AND IT'S COMPONENTS \n 1. Blood is a fluid that transports oxygen and nutrients to the cells and carries away carbon dioxide and other waste products. \n 2. Blood contains of 55% of plasma, 1% of platelets and white blood cells and 44% of red blood cells \n 3. Donor's can donate whole blood or any required components like red blood cells, plasma and platelets. This process is known as apheresis and plateletpheresis \n 4. Platelets must be donated within 5 days of time \n",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 18),
                  ))),
              SizedBox(height: 25.0),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.red[100],
                  ])),
                  child: SizedBox(
                      child: new Text(
                    "\n ABOUT BLOOD DONATION PROCESS \n 1. It is a simple process of registration, medical history and mini-physical, donation and refreshments. \n 2. Blood donation is a safe and simple process and the needle is used for one donor and then needle will be disposed \n 3. Blood donation process takes around 8-10 minutes or sometimes 12 minutes. \n 4. An average adult consists of 1.2-1.5 gallons of blood i.e 10 units of blood and 1 unit approximately is given during a donation \n 5. All the donor's are requested to take the basic tests to ensure that it is safe for the donor to give blood \n",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 18),
                  ))),
              SizedBox(height: 25.0),
            ],
          )),
        ));
  }
}
