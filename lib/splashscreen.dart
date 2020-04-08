import 'dart:async';
//import 'package:FinAd/login.dart';
import 'package:FinAd/pages/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:FinAd/services/authentication.dart';
//import 'package:FinAd/pages/root_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => new LoginSignupPage(auth: new Auth())));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("s1.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "FinAd",
              style: TextStyle(fontSize: 75.0, color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
