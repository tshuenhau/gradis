import 'package:flutter/material.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
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
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Material(
              color: GreenHighlight,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () async {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Okay',
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
