import 'package:flutter/material.dart';

class Submit extends StatefulWidget {
  @override
  SubmitPage createState() => SubmitPage();
}

class SubmitPage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Text(
              'Thank you. Your form has been submitted. We recommend you this agent......',
              style: TextStyle(
                fontSize: 20,
              ))
        ]))));
  }
}
