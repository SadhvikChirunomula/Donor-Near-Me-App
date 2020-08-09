import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class DeveloperContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Abhishek Doshi',
          textColor: Colors.white,
          backgroundColor: Colors.teal.shade300,
          email: 'adoshi26.ad@gmail.com',
        ),
        backgroundColor: Colors.teal,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('assests/logo.png'),
          email: 'sadhu1998@gmail.com',
          companyName: 'Epsilon Infinity Services',
          companyColor: Colors.teal.shade100,
          phoneNumber: '+919160230298',
          website: 'https://epsiloninfinityservices.com',
          githubUserName: 'sadhu1998',
          linkedinURL: 'https://www.linkedin.com/sadhu1998',
          tagLine: 'Software Developer',
          taglineColor: Colors.teal.shade100,
          instagram: 'j_a_r_v_i_s________',
        ),
      ),
    );
  }
}