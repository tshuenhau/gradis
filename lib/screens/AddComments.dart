import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:gradis/classes/GoalCAP.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/ForumAPI.dart';
import 'package:gradis/classes/Comment.dart';
import 'package:gradis/classes/module.dart';

Future<dynamic> buildSettingsBottomSheet(
    BuildContext context, Module module, double workload, double difficulty) {
  final _auth = FirebaseAuth.instance;
  late double goal;
  late String name;
  late String comment;
  late String ays;

  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              color: ModuleTileColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              children: <Widget>[
                Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your name'),
                ),
                Text(
                  "Semester",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    ays = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your semester'),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Comment",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    comment = value;
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your comment'),
                ),
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
                      //implement submission to firestore
                      Comment newComment = new Comment(
                          name: name,
                          comment: comment,
                          ays: ays,
                          module: "",
                          workload: workload,
                          difficulty: difficulty,
                          likes: 0,
                          dislikes: 0);
                      Provider.of<ForumAPI>(context, listen: false)
                          .createComment(newComment);
                      Navigator.pop(context);
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
              ],
            ),
          ),
        );
      });
}
