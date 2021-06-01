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
            stream:
                Provider.of<UserAPI>(context, listen: false).findAllModules(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final modules = snapshot.data!.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> document) {
                  final data = document;
                  return Module.fromFirestore(data);
                }).toList();
                print('modules');
                print(modules);
                Provider.of<UserAPI>(context, listen: false)
                    .setModules(modules);
                return Container(
                  constraints: BoxConstraints.expand(),
                  child: Consumer<UserAPI>(
                    builder: (context, modules, child) {
                      return ListView.builder(
                        //  / reverse: true,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: Provider.of<UserAPI>(context, listen: false)
                            .modules
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  isThreeLine: false,
                                ),
                              ),
                              Divider(height: 10, thickness: 1),
                            ]);
                          }
                          return Container(
                            child: ModuleTile(
                              index: index,
                              module:
                                  Provider.of<UserAPI>(context, listen: false)
                                      .modules[index],
                              key: ValueKey(
                                  Provider.of<UserAPI>(context, listen: false)
                                      .modules[index]
                                      .id),
                            ),
                          );
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
