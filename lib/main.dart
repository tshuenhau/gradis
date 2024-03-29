import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/InputPage.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/screens/authentication/LoginScreen.dart';
import 'package:gradis/screens/authentication/RegistrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/screens/authentication/ForgotPasswordScreen.dart';
import 'package:gradis/screens/authentication/ConfirmEmailScreen.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/services/SentimentAPI.dart';
import 'package:gradis/services/GlobalSentimentAPI.dart';
import 'package:gradis/services/SearchAPI.dart';
import 'package:gradis/services/ForumAPI.dart';
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
          // checkLoggedIn();

          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserAPI>(create: (context) => UserAPI()),
              ChangeNotifierProvider<SentimentAPI>(
                  create: (context) => SentimentAPI()),
              ChangeNotifierProvider<GlobalSentimentAPI>(
                  create: (context) => GlobalSentimentAPI()),
              ChangeNotifierProvider<SearchAPI>(
                  create: (context) => SearchAPI()),
              ChangeNotifierProvider<ForumAPI>(create: (context) => ForumAPI()),
            ],
            child: MaterialApp(
              theme: gradisTheme,
              initialRoute: FirebaseAuth.instance.currentUser != null
                  ? InputPage.id
                  : WelcomeScreen.id,
              routes: {
                WelcomeScreen.id: (context) => WelcomeScreen(),
                LoginScreen.id: (context) => LoginScreen(),
                ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
                RegistrationScreen.id: (context) => RegistrationScreen(),
                ConfirmEmailScreen.id: (context) => ConfirmEmailScreen(),
                InputPage.id: (context) => InputPage()
              },
            ),
          );
        }
        return MaterialApp(
          theme: gradisTheme,
          home: Scaffold(),
        );
      },
    );
  }
}

// void checkLoggedIn() {
//   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//       isLoggedIn = false;
//     } else {
//       print('User is signed in!');
//       isLoggedIn = true;
//     }
//   });
// }
