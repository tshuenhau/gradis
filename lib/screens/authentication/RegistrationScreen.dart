import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/authentication/ConfirmEmailScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String errorText = "";
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
            // Container(
            //   height: 200.0,
            //   child: Image.asset('images/logo.png'),
            // ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
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
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              errorText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: BlueHighlight,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    //Implement registration functionality.
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      await newUser.user!.sendEmailVerification();

                      Navigator.pushNamed(context, ConfirmEmailScreen.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        print('Your password is weak');
                        setState(() {
                          errorText = 'Your password is too weak';
                        });
                      } else if (e.code == 'weak-password') {
                        print('The account already exists for that email.');
                        setState(() {
                          errorText =
                              'The account already exists for that email.';
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
