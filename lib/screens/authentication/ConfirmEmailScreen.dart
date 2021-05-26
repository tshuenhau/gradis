import 'package:flutter/material.dart';
import 'package:gradis/screens/authentication/LoginScreen.dart';
import 'package:gradis/constants.dart';

class ConfirmEmailScreen extends StatelessWidget {
  static String id = 'confirm-email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'An email has just been sent to you. Click the link provided to complete registration',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Material(
              color: GreenAccent,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () async {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
