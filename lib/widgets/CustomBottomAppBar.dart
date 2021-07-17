import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/Settings.dart';
import 'package:gradis/screens/Feedback.dart';
import 'package:gradis/screens/Search.dart';

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
    bool hasData = true;

    return BottomAppBar(
      color: PrimaryColor,
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: MediaQuery.of(context).size.height / 15,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                color: IconsColor,
                onPressed: () {
                  buildSearchPage(context, hasData);
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
                  buildSettingsBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
