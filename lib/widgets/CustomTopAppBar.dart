import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradis/constants.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopAppBar({
    Key? key,
    required this.height,
    required FirebaseFirestore firestore,
    required this.loggedInUser,
  })  : _firestore = firestore,
        super(key: key);

  final double height;
  final FirebaseFirestore _firestore;
  final User loggedInUser;

  @override
  get preferredSize => Size.fromHeight(height / 12);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('modules')
              .where('user', isEqualTo: loggedInUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<UserAPI>(builder: (context, modulesData, child) {
                return Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Total",
                                textAlign: TextAlign.left,
                                style: titleTextStyle,
                              ),
                              Text(
                                Provider.of<UserAPI>(context, listen: false)
                                    .calculateTotalCAP()
                                    .toStringAsFixed(2),
                                textAlign: TextAlign.left,
                                style: capTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Current",
                                textAlign: TextAlign.left,
                                style: titleTextStyle,
                              ),
                              Text(
                                Provider.of<UserAPI>(context, listen: false)
                                    .calculateCurrentCAP()
                                    .toStringAsFixed(2),
                                textAlign: TextAlign.left,
                                style: capTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: const Text(
                            "Gradis",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Future",
                                textAlign: TextAlign.left,
                                style: titleTextStyle,
                              ),
                              Text(
                                Provider.of<UserAPI>(context, listen: false)
                                    .calculateFutureCAP()
                                    .toStringAsFixed(2),
                                textAlign: TextAlign.left,
                                style: capTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Goal",
                                textAlign: TextAlign.left,
                                style: titleTextStyle,
                              ),
                              StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: new UserAPI().findGoalCAP(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.docs.isNotEmpty) {
                                      final goalCAP = snapshot.data!.docs.map(
                                          (DocumentSnapshot<
                                                  Map<String, dynamic>>
                                              document) {
                                        return document.data()!['CAP'];
                                      }).toList()[0];
                                      final id = snapshot.data!.docs[0].id;
                                      UserAPI.setGoalCAP(goalCAP);

                                      return GoalCAPTextField(
                                          id: id,
                                          initialText:
                                              goalCAP.toStringAsFixed(2));
                                    } else {
                                      print('first time');
                                      return GoalCAPTextField(
                                          id: 'first-creation',
                                          initialText: '');
                                    }
                                  })
                            ],
                          ),
                        ),
                      ]),
                );
              });
            } else {
              return Text("", style: const TextStyle());
            }
          }),
    );
  }
}
