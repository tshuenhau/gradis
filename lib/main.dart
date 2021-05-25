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

void main() => runApp(MyApp());

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
                ),
                home: InputPage(),
                initialRoute: WelcomeScreen.id,
                routes: {
                  WelcomeScreen.id: (context) => WelcomeScreen(),
                  LoginScreen.id: (context) => LoginScreen(),
                  RegistrationScreen.id: (context) => RegistrationScreen(),
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
