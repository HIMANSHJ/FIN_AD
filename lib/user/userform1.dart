import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:quiver/strings.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:FinAd/services/submit.dart';
import 'package:firebase_database/firebase_database.dart';

class UserForm1 extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<UserForm1> {

  FirebaseDatabase dbref1 = FirebaseDatabase.instance;

  final _formKey = GlobalKey<FormState>();
  //var _passKey = GlobalKey<FormFieldState>();
  // String _password = '';
  String name = '';
  var address = '';
  var email;
  int agelife;
  int moblife;
  int salary;
  String insurance = 'Personal';
  String _maritalStatuslife = 'Married';
  bool _termsChecked = true;
  var _genderlife = ['Male', 'Female', 'Other'];
  var _currentItemSelectedlife = 'Male';

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelectedlife = newValueSelected;
    });
  }

  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: new ListView(
              children: getFormWidget(),
            )));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Enter Name',
            hintText: 'Name'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            name = value;
          });
        }));

    formWidget.add(new TextFormField(
      decoration: new InputDecoration(
        icon: const Icon(Icons.calendar_today),
        hintText: 'DD/MM/YYYY',
        labelText: 'Dob',
      ),
      controller: _controller,
      keyboardType: TextInputType.datetime,
    ));
    new IconButton(
      icon: new Icon(Icons.more_horiz),
      tooltip: 'Choose date',
      onPressed: (() {
        _chooseDate(context, _controller.text);
      }),
    );

    formWidget.add(new TextFormField(
      maxLength: 3,
      decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today),
          hintText: 'Age',
          labelText: 'Enter your Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return 'Enter Age';
        return null;
      },
      onSaved: (value) {
        setState(() {
          agelife = int.tryParse(value);
        });
      },
    ));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.business),
            labelText: 'Enter Address',
            hintText: 'Address'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your address';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            address = value;
          });
        }));

    formWidget.add(new TextFormField(
        maxLength: 10,
        decoration: const InputDecoration(
          icon: const Icon(Icons.phone),
          hintText: 'Enter a phone number',
          labelText: 'Phone',
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value.isEmpty) return 'Enter your Mobile Number';
          return null;
        },
        onSaved: (value) {
          setState(() {
            moblife = int.tryParse(value);
          });
        }));

    String validateEmail(String value) {
      if (value.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Enter Email',
            hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onSaved: (value) {
          setState(() {
            email = value;
          });
        }));
    formWidget.add(new TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
          icon: const Icon(Icons.person_pin_circle),
          hintText: 'Salary',
          labelText: 'Salary'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return 'Enter your salary';
        return null;
      },
      onSaved: (value) {
        setState(() {
          salary = int.tryParse(value);
        });
      },
    ));

    formWidget
        .add(new FormField<String>(builder: (FormFieldState<String> state) {
      return InputDecorator(
        decoration: InputDecoration(
          icon: const Icon(Icons.account_box),
          labelText: 'Type of insurance',
        ),
        child: new Column(
          children: <Widget>[
            RadioListTile<String>(
              title: const Text('Personal'),
              value: 'personal',
              groupValue: insurance,
              onChanged: (value) {
                setState(() {
                  insurance = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Family'),
              value: 'family',
              groupValue: insurance,
              onChanged: (value) {
                setState(() {
                  insurance = value;
                });
              },
            ),
          ],
        ),
      );
    }));

    formWidget.add(
      new FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
              decoration: InputDecoration(
                icon: const Icon(Icons.accessibility),
                labelText: 'Gender',
              ),
              child: new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                items: _genderlife.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  // Your code to execute, when a menu item is selected from drop down
                  _onDropDownItemSelected(newValueSelected);
                },
                value: _currentItemSelectedlife,
              )));
        },
      ),
    );

    formWidget
        .add(new FormField<String>(builder: (FormFieldState<String> state) {
      return InputDecorator(
        decoration: InputDecoration(
          icon: const Icon(Icons.account_circle),
          labelText: 'Marital Status',
        ),
        child: new Column(
          children: <Widget>[
            RadioListTile<String>(
              title: const Text('Unmarried'),
              value: 'Unmarried',
              groupValue: _maritalStatuslife,
              onChanged: (value) {
                setState(() {
                  _maritalStatuslife = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Married'),
              value: 'married',
              groupValue: _maritalStatuslife,
              onChanged: (value) {
                setState(() {
                  _maritalStatuslife = value;
                });
              },
            ),
          ],
        ),
      );
    }));

    /*formWidget.add(new TextFormField(
        key: _passKey,
        obscureText: true,
        decoration: InputDecoration(
            icon: const Icon(Icons.book),
            hintText: 'Password',
            labelText: 'Enter Password'),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter password';
          if (value.length < 8)
            return 'Password should be more than 8 characters';
          return null;
        }));

    formWidget.add(
      new TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              icon: const Icon(Icons.book),
              hintText: 'Confirm Password',
              labelText: 'Enter Confirm Password'),
          validator: (confirmPassword) {
            if (confirmPassword.isEmpty) return 'Enter confirm password';
            var password = _passKey.currentState.value;
            if (!equalsIgnoreCase(confirmPassword, password))
              return 'Confirm Password invalid';
            return null;
          },
          onSaved: (value) {
            setState(() {});
          }),
    );*/

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value;
        });
      },
      subtitle: !_termsChecked
          ? Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: new Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Confirm'),
        onPressed: onPressedSubmit));
    return formWidget;
  }

  void onPressedSubmit() {
    if (_formKey.currentState.validate() && _termsChecked) {
      _formKey.currentState.save();

       navigateToSubmitPage(context);

      //  print("Name " + name);
      // print("Email " + email);
      // print("Address " + address);
      // print("Mobile Number " + mob.toString());
      // print("Age " + age.toString());
      // // print("Password " + _password);
      // print("Salary " + salary.toString());
      // print("Insurance type " + insurance);
      // print("Gender " + _currentItemSelectedlife);
      // print("Marital Status " + _maritalStatuslife);
      // print("Termschecked " + _termsChecked.toString());

      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("name")
          .set(name);
       dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("age")
          .set(agelife);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("email")
          .set(email);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("address")
          .set(address);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("mobile no.")
          .set(moblife);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("salary")
          .set(salary);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("Insurance type")
          .set(insurance);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("Gender")
          .set(_currentItemSelectedlife);
      dbref1
          .reference()
          .child("User1")
          .child("user1_id")
          .child("Maritial status")
          .set(_maritalStatuslife);
      // dbref1
      //     .reference()
      //     .child("Agents")
      //     .child("agent_id")
      //     .child("password")
      //     .set(_password);
     
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }

  Future navigateToSubmitPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Submit()));
  }
}
