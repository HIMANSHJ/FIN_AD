import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:quiver/strings.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'submit.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  FirebaseDatabase dbref = FirebaseDatabase.instance;

  final _formKey = GlobalKey<FormState>();
  //var _passKey = GlobalKey<FormFieldState>();
  String name = '';
  var address = '';
  int mob;
  // String _password = '';
  String _maritalStatus = 'Unmarried';
  bool _termsChecked = true;
  var email;
  int age;
  int postCode;
  String comAff;
  String comAffBranch;
  var _currencies = ['Male', 'Female', 'Other'];
  var _currentItemSelected = 'Male';

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
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
          if (value.isEmpty && value.length < 10)
            return 'Enter your Mobile Number';
          return null;
        },
        onSaved: (value) {
          setState(() {
            mob = int.tryParse(value);
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
      decoration: InputDecoration(
          icon: const Icon(Icons.person_pin_circle),
          hintText: 'Postcode',
          labelText: 'Enter Postcode'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return 'Enter Postcode';
        return null;
      },
      onSaved: (value) {
        setState(() {
          postCode = int.tryParse(value);
        });
      },
    ));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.business_center),
            labelText: 'Enter the companies affiliated',
            hintText: 'Companies'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your affiliated companies';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            comAff = value;
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.business_center),
            labelText: 'Enter the companies affiliated branches',
            hintText: 'Branches'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your affiliated companies branches';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            comAffBranch = value;
          });
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
                items: _currencies.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  // Your code to execute, when a menu item is selected from drop down
                  _onDropDownItemSelected(newValueSelected);
                },
                value: _currentItemSelected,
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
              groupValue: _maritalStatus,
              onChanged: (value) {
                setState(() {
                  _maritalStatus = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Married'),
              value: 'married',
              groupValue: _maritalStatus,
              onChanged: (value) {
                setState(() {
                  _maritalStatus = value;
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
      print("Name " + name);
      print("Email " + email);
      print("Address " + address);
      print("Mobile Number " + mob.toString());
      print("Age " + age.toString());
      print("Postal Code " + postCode.toString());
      print("Companies affiliated " + comAff);
      print("Companies affiliated branches " + comAffBranch);
      print("Gender " + _currentItemSelected);
      print("Marital Status " + _maritalStatus);
      print("Termschecked " + _termsChecked.toString());
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("name")
          .set(name);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("email")
          .set(email);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("address")
          .set(address);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("mobile no.")
          .set(mob);
      dbref
           .reference()
           .child("Agents")
           .child("agent_id")
           .child("age")
           .set(age);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("postal code")
          .set(postCode);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("Companies affiliated")
          .set(comAff);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("Companies affiliated branches")
          .set(comAffBranch);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("Gender")
          .set(_currentItemSelected);
      dbref
          .reference()
          .child("Agents")
          .child("agent_id")
          .child("maritialstatus")
          .set(_maritalStatus);
      // dbref
      //     .reference()
      //     .child("Agents")
      //     .child("agent_id")
      //     .child("password")
      //     .set(_password);
      navigateToSubmitPage(context);
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }

  Future navigateToSubmitPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Submit()));
  }
}
