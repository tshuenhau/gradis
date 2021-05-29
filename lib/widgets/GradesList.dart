import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/classes/module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextAlign alignment = TextAlign.center;

class GradesList extends StatelessWidget {
  const GradesList({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: new UserAPI().findAllModules(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final modules = snapshot.data!.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> document) {
                  final data = document.data()!;

                  return new Module(
                      id: document.id,
                      ays: data['ays'],
                      workload: data['workload'],
                      difficulty: data['difficulty'],
                      su: data['su'],
                      name: data['name'],
                      grade: data['grade'],
                      done: data['done'],
                      credits: data['credits']);
                }).toList();
                UserAPI.setModules(modules);
                print(UserAPI.modules);
                return Container(
                  constraints: BoxConstraints.expand(),
                  child: Consumer<UserAPI>(
                    builder: (context, modules, child) {
                      return ListView.builder(
                        //  / reverse: true,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: UserAPI.modules
                            .length, // for the done , module, credits, grade header at index 0
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(children: <Widget>[
                              Container(
                                color: ModuleTileColor,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: ListTile(
                                  leading: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.0, left: 7.0),
                                    child: Text(
                                      'Done',
                                      textAlign: alignment,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  title: Consumer<UserAPI>(
                                      builder: (context, modulesData, child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Module',
                                            textAlign: alignment,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Credits',
                                            textAlign: alignment,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Grade',
                                            textAlign: alignment,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
//                    trailing: Icon(Icons.arrow_drop_up, color: Colors.green),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  isThreeLine: false,
                                ),
                              ),
                              Divider(height: 10, thickness: 1),
                            ]);
                          }
                          print(UserAPI.modules);
                          return Container(
                              child: ModuleTile(index, UserAPI.modules[index]));
                        },
                      );
                    },
                  ),
                );
              } else
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Accent,
                  ),
                  child: Text("Loading"),
                );
            }),
      ),
    ]);
  }
}
