import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:gradis/classes/GoalCAP.dart';
import 'package:provider/provider.dart';

Future<dynamic> buildSettingsBottomSheet(BuildContext context) {
  final _auth = FirebaseAuth.instance;
  late double goal;

  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 800,
          decoration: BoxDecoration(
            color: ModuleTileColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: <Widget>[
                Text(
                  "Set Goal GPA",
                  textAlign: TextAlign.center,
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
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);

                      GoalCAP updatedGoalGPA = new GoalCAP(
                          id: Provider.of<UserAPI>(context, listen: false)
                                      .goalCAP !=
                                  null
                              ? Provider.of<UserAPI>(context, listen: false)
                                  .goalCAP!
                                  .getGoalCapId()
                              : "",
                          goal: goal);
                      Provider.of<UserAPI>(context, listen: false).updateGoalCAP(
                          updatedGoalGPA); //TODO: ZQ HERE MUST CHANGE THE GOAL WITH API
                      //Implement registration functionality. //TODO: ZQ HERE MUST CHANGE THE GOAL WITH API
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
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      //TODO: ZQ HERE MAKE THE FCKER LOG OUT.
                      _auth.signOut();
                    },
                    minWidth:
                        200.0, //!!! Why this size smaller when all other buttons also 200.0
                    height: 42.0,
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
