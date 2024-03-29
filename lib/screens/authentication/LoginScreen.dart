import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/InputPage.dart';
import 'package:gradis/screens/authentication/ForgotPasswordScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  String incorrectText = "";
  bool _firstPressed = false; // used to prevent login to happen multiple times

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Register"), backgroundColor: Colors.transparent),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: greenTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: greenTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Text(incorrectText,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.redAccent)),
                        ),
                        Material(
                          color: Highlight,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              //Implement registration functionality.
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: this.email, password: this.password);
                                if (!_firstPressed) {
                                  Navigator.pushNamed(context, InputPage.id);
                                  _firstPressed = true;
                                }
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  incorrectText = "Incorrect email/password.";
                                });
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                            minWidth:
                                200.0, //!!! Why this size smaller when all other buttons also 200.0
                            height: 42.0,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Material(
                          color: BlueHighlight,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.id);
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ])),
            ],
          )),
    );
  }
}
