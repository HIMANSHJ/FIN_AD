import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:quiver/strings.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:FinAd/services/submit.dart';
import 'package:firebase_database/firebase_database.dart';

class UserForm4 extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<UserForm4> {

  FirebaseDatabase dbref4 = FirebaseDatabase.instance;

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
  var location;
  String state;
  int pincode;
  int price;
  var _gender = ['Male', 'Female', 'Other'];
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
          age = int.tryParse(value);
        });
      },
    ));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.business),
            labelText: 'Enter Your Address',
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
            icon: const Icon(Icons.business),
            labelText: 'Enter Property Location',
            hintText: 'Location'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your property location';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            location = value;
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            icon: const Icon(Icons.business),
            labelText: 'State',
            hintText: 'Property Area'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter state';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            state = value;
          });
        }));

    formWidget.add(new TextFormField(
      maxLength: 6,
      decoration: InputDecoration(
          icon: const Icon(Icons.person_pin_circle),
          hintText: 'Areacode',
          labelText: 'Enter Pin Code'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return 'Enter Pincode';
        return null;
      },
      onSaved: (value) {
        setState(() {
          pincode = int.tryParse(value);
        });
      },
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          icon: const Icon(Icons.account_balance_wallet),
          hintText: 'Price',
          labelText: 'Property Price'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return 'Enter the price';
        return null;
      },
      onSaved: (value) {
        setState(() {
          price = int.tryParse(value);
        });
      },
    ));

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
                items: _gender.map((String dropDownStringItem) {
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
              value: 'unmarried',
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

      // print("Name " + name);
      // print("Email " + email);
      // print("Address" + address);
      // print("Mobile NO." + mob.toString());
      // print("Postcode " + age.toString());
      // print("Marital Status " + _maritalStatus);
      // print("Termschecked " + _termsChecked.toString());
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Form Submitted')));

       dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("name")
          .set(name);
       dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("age")
          .set(age);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("email")
          .set(email);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("address")
          .set(address);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("mobile number")
          .set(mob);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("Property price")
          .set(price);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("Property location")
          .set(location);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("state")
          .set(state);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("pincode")
          .set(pincode);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("Gender")
          .set(_currentItemSelected);
      dbref4
          .reference()
          .child("User4")
          .child("user4_id")
          .child("Maritial status")
          .set(_maritalStatus);

    }
  }
  Future navigateToSubmitPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Submit()));
  }
}
