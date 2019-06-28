import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email_signin/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Email Registration'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     Form(
                      key: _formStateKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateEmail,
                              onSaved: (value) {
                                _emailId = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailIdController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.green,
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                // hintText: "Company Name",
                                labelText: "Email Id",
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validatePassword,
                              onSaved: (value) {
                                _password = value;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                // hintText: "Company Name",
                                labelText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateConfirmPassword,
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                // hintText: "Company Name",
                                labelText: "Confirm Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()),
                    ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Registration',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              if (_formStateKey.currentState.validate()) {
                                _formStateKey.currentState.save();
                                signUp(_emailId, _password).then((user) {
                                  if (user != null) {
                                    print('Registered Successfully.');
                                    setState(() {
                                      successMessage =
                                          'Registered Successfully.\nYou can now navigate to Login Page.';
                                    });
                                  } else {
                                    print('Error while Login.');
                                  }
                                });
                              }
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (successMessage != ''
                ? Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.green),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signUp(email, password) async {
    try {
      FirebaseUser user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }
}
