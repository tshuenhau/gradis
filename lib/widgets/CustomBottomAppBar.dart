import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatelessWidget {
  // const CustomBottomAppBar({Key? key}): super(key: key);

  final _auth = FirebaseAuth.instance;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BottomAppBar(
      color: PrimaryColor,
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: height / 15,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip:
                    'Open navigation menu', // this opens up like the side appbar where u can select the semester
                icon: const Icon(Icons.menu),
                color: IconsColor,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                color: IconsColor,
                onPressed: () {
                  print(Provider.of<UserAPI>(context, listen: false).modules);
                },
              ),
              if (centerLocations
                  .contains(FloatingActionButtonLocation.centerDocked))
                const Spacer(),
              IconButton(
                tooltip: 'Settings', // settings and goal
                icon: const Icon(Icons.settings),
                color: IconsColor,
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
