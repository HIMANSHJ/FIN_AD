import 'package:FinAd/agentform.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'agentform.dart';
import 'thirdpage.dart';
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

/*class MainPage extends State<MyApp> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  updateTodo(Todo todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }
  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.done_outline,
                            color: Colors.green,
                            size: 20.0,
                          )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                      updateTodo(_todoList[index]);
                    }),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }*/

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
                    child: Text('Sign Out'),
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
              title: Text('Policy Page'),
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
              title: Text('Agent Register'),
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
              child: Text('OLD POLICY'),
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

/*abstract class BaseAuth {

  Future<void> signOut();
  
}

 class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }}*/
