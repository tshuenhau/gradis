import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/InputPage.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/screens/authentication/LoginScreen.dart';
import 'package:gradis/screens/authentication/RegistrationScreen.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/screens/authentication/ForgotPasswordScreen.dart';
import 'package:gradis/screens/authentication/ConfirmEmailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

bool isLoggedIn = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('error');
          return MaterialApp();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          checkLoggedIn();
          return ChangeNotifierProvider<UserAPI>(
            create: (context) => UserAPI(),
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: MaterialApp(
                theme: ThemeData.dark().copyWith(
                  primaryColor: Colors.black,
                  accentColor: GreenHighlight,
                  backgroundColor: Colors.greenAccent,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: GreenHighlight.withOpacity(.6),
                    selectionHandleColor: GreenHighlight.withOpacity(1),
                  ),
                ),
                home: InputPage(),
                initialRoute: isLoggedIn ? InputPage.id : WelcomeScreen.id,
                routes: {
                  WelcomeScreen.id: (context) => WelcomeScreen(),
                  LoginScreen.id: (context) => LoginScreen(),
                  ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
                  RegistrationScreen.id: (context) => RegistrationScreen(),
                  ConfirmEmailScreen.id: (context) => ConfirmEmailScreen(),
                  InputPage.id: (context) => InputPage()
                },
              ),
            ),
          );
        }
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.greenAccent,
            accentColor: GreenHighlight,
            backgroundColor: Colors.greenAccent,
          ),
          home: Scaffold(),
        );
      },
    );
  }
}

void checkLoggedIn() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      isLoggedIn = false;
    } else {
      print('User is signed in!');
      isLoggedIn = true;
    }
  });
}
