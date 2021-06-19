import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/screens/InputPage.dart';

enum AuthStatus { isLoggedIn, isNotLoggedIn }

class AuthenticationAPI extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.isNotLoggedIn;

  void checkLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        authStatus = AuthStatus.isNotLoggedIn;
      } else {
        print('User ${user} is signed in!');
        authStatus = AuthStatus.isLoggedIn;
      }
    });
  }

  getHomePage() {
    if (authStatus == AuthStatus.isLoggedIn) {
      return InputPage();
    } else {
      return WelcomeScreen();
    }
  }
}
