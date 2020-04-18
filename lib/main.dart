import 'package:FinAd/agent/agentform.dart';
import 'package:flutter/material.dart';
import 'package:FinAd/main/splashscreen.dart';
import 'package:FinAd/main/thirdpage.dart';
import 'dart:async';
//import 'package:firebase_database/firebase_database.dart';
//import 'todo.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:FinAd/services/authentication.dart';

void main() => runApp(MaterialApp(
    title: "FinAd", debugShowCheckedModeBanner: false, home: SplashScreen()));

class MyApp extends StatefulWidget {
  /*MyApp({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;*/

  @override
  MainPage createState() => MainPage();
}

class MainPage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              'assets/tlogo.png',
            ),
          ),
          Text(
            'FinAd',
            style: TextStyle(
              fontSize: 70,
            ),
          ),
          Text(
            'Your Financial Advisor',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          ),
          Container(
              margin: new EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.people, color: Colors.blueAccent),
                    onPressed: () {
                      navigateToSubPage(context);
                    },
                  ),
                  RaisedButton(
                      child: Text("USER"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                      onPressed: () {
                        navigateToSubPage(context);
                      }),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.account_box, color: Colors.blueAccent),
                    onPressed: () {
                      navigateToAgentFormPage(context);
                    },
                  ),
                  RaisedButton(
                    child: Text("AGENT"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                    splashColor: Colors.grey,
                    onPressed: () {
                      navigateToAgentFormPage(context);
                    },
                  ),
                  IconButton(
                    iconSize: 45,
                    icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('SIGN OUT'),
                    onPressed: () {
                      backToSignUpPage(context);
                    },
                  )
                ],
              ))
        ],
      )),
    ));
  }

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }

  Future navigateToAgentFormPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpForm()));
  }

  void backToLoginPage(context) {
    Navigator.pop(context);
  }

  void backToSignUpPage(context) {
    Navigator.pop(context);
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER HOME'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("USER"),
              accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('NEW POLICY'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ThirdPage()));
              },
            ),
             ListTile(
              title: Text('RENEW POLICY'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ThirdPage()));
              },
            ),
            ListTile(
              title: Text('AGENT REGISTRATION'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SignUpForm()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.control_point, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('NEW POLICY'),
              onPressed: () {
                navigateToThirdPage(context);
              },
            ),
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.book, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('RENEW POLICY'),
              onPressed: () {
                navigateToThirdPage(context);
              },
            ),
            IconButton(
              iconSize: 45,
              icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
              onPressed: () {},
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('BACK'),
              onPressed: () {
                backToMainPage(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Future navigateToThirdPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ThirdPage()));
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}
