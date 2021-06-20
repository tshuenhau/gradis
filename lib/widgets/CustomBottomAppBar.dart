import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:gradis/classes/GoalCAP.dart';

import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatelessWidget {
  // const CustomBottomAppBar({Key? key}): super(key: key);
  late double goal;
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
                  // _auth.signOut();
                  // Navigator.pushNamed(context, WelcomeScreen.id);
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 800,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  "Set Goal GPA",
                                  textAlign: TextAlign.center,
<<<<<<< HEAD
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      goal = double.parse(value);
                                    },
                                    decoration: kTextFieldDecoration.copyWith(
                                        hintText: 'Enter your Goal')),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Material(
                                  color: Highlight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      print("Submit");
                                      print(goal);
                                      setGoalCAP(
                                          goal); //TODO: ZQ HERE MUST CHANGE THE GOAL WITH API
                                      //Implement registration functionality.
                                    },
                                    minWidth:
                                        200.0, //!!! Why this size smaller when all other buttons also 200.0
                                    height: 42.0,
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Material(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      print("Log Out");
                                      print(goal);
                                      //TODO: ZQ HERE MAKE THE FCKER LOG OUT.
                                    },
                                    minWidth:
                                        200.0, //!!! Why this size smaller when all other buttons also 200.0
                                    height: 42.0,
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(color: Colors.black),
                                    ),
=======
                                  onChanged: (value) {
                                    goal = double.parse(value);
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter your Goal')),
                              SizedBox(
                                height: 8.0,
                              ),
                              Material(
                                color: Highlight,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                elevation: 5.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    print("Submit");
                                    print(goal);
                                    GoalCAP updatedGoalGPA = new GoalCAP(
                                        id: Provider.of<UserAPI>(context,
                                                        listen: false)
                                                    .goalCAP !=
                                                null
                                            ? Provider.of<UserAPI>(context,
                                                    listen: false)
                                                .goalCAP!
                                                .getGoalCapId()
                                            : "",
                                        goal: goal);
                                    Provider.of<UserAPI>(context, listen: false)
                                        .updateGoalCAP(
                                            updatedGoalGPA); //TODO: ZQ HERE MUST CHANGE THE GOAL WITH API
                                    //Implement registration functionality.
                                  },
                                  minWidth:
                                      200.0, //!!! Why this size smaller when all other buttons also 200.0
                                  height: 42.0,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.black),
>>>>>>> 541b2350a7cd57d147bd9d1814aec92fc531390d
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
