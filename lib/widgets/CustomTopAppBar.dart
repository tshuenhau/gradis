import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/classes/GoalCAP.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopAppBar({
    Key? key,
    required this.context,
    required this.loggedInUser,
  }) : super(key: key);

  final BuildContext context;
  final User loggedInUser;

  @override
  get preferredSize => Size.fromHeight(MediaQuery.of(context).size.height / 12);

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
      title: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Provider.of<UserAPI>(context, listen: false).findAllModules(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                            StreamBuilder<GoalCAP>(
                              stream:
                                  Provider.of<UserAPI>(context, listen: false)
                                      .findGoalCAP(),
                              builder: (context, snapshot) {
                                print(snapshot);
                                if (snapshot.hasData) {
                                  GoalCAP? goalCAP = snapshot.data;
                                  print(goalCAP);
                                  Provider.of<UserAPI>(context, listen: false)
                                      .setGoalCAP(goalCAP!);
                                  print(Provider.of<UserAPI>(context,
                                          listen: false)
                                      .goalCAP);
                                  if (goalCAP.id == '') {
                                    return Text(
                                      'N/A',
                                      style: capTextStyle,
                                    );
                                  } else {
                                    return Text(
                                      goalCAP.getGoalCap().toStringAsFixed(2),
                                      style: capTextStyle,
                                    );
                                  }
                                } else {
                                  return Text('N/A');
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // Expanded( //? this is the backup (old version of goalcap)
                      //   child: Column(
                      //     children: [
                      //       const Text(
                      //         "Goal",
                      //         textAlign: TextAlign.left,
                      //         style: titleTextStyle,
                      //       ),
                      //       StreamBuilder<GoalCAP>(
                      //         stream:
                      //             Provider.of<UserAPI>(context, listen: false)
                      //                 .findGoalCAP(),
                      //         builder: (context, snapshot) {
                      //           if (snapshot.hasData) {
                      //             final goalCAP = snapshot.data;
                      //             final id = goalCAP!.id;
                      //             Provider.of<UserAPI>(context, listen: false)
                      //                 .setGoalCAP(goalCAP);

                      //             return GoalCAPTextField(
                      //                 id: id,
                      //                 initialText:
                      //                     goalCAP.goal.toStringAsFixed(2));
                      //           } else {
                      //             return GoalCAPTextField(
                      //                 id: 'first-creation', initialText: '');
                      //           }
                      //         },
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ]),
              );
            } else {
              return Text("", style: const TextStyle());
            }
          }),
    );
  }
}
