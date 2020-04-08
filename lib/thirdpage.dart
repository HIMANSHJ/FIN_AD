import 'package:flutter/material.dart';
import 'userform1.dart';
import 'userform2.dart';
import 'userform3.dart';
import 'userform4.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POLICIES'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 60,
              icon: Icon(Icons.accessibility, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('LIFE INSURANCE'),
              onPressed: () {
                navigateToUserForm1Page(context);
              },
            ),
            IconButton(
              iconSize: 60,
              icon: Icon(Icons.enhanced_encryption, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('HEALTH INSURANCE'),
              onPressed: () {
                navigateToUserForm2Page(context);
              },
            ),
            IconButton(
              iconSize: 60,
              icon: Icon(Icons.airport_shuttle, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('VEHICLE INSURANCE'),
              onPressed: () {
                navigateToUserForm3Page(context);
              },
            ),
            IconButton(
              iconSize: 60,
              icon: Icon(Icons.domain, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('PROPERTY INSURANCE'),
              onPressed: () {
                navigateToUserForm4Page(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void backToSubPage(context) {
    Navigator.pop(context);
  }

  Future navigateToUserForm1Page(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm1()));
  }

  Future navigateToUserForm2Page(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm2()));
  }

  Future navigateToUserForm3Page(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm3()));
  }

  Future navigateToUserForm4Page(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm4()));
  }
}
