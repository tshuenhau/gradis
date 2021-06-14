import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/classes/module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradis/widgets/GPATrend.dart';
import 'package:gradis/widgets/FilterChips.dart';

TextAlign alignment = TextAlign.center;

class GradesList extends StatefulWidget {
  GradesList({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  String ays = "";

  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  bool hasData = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Provider.of<UserAPI>(context, listen: false)
              .findModulesBySemester(
                  Provider.of<UserAPI>(context, listen: true).ays),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              hasData = true;
              final modules = snapshot.data!.docs
                  .map((DocumentSnapshot<Map<String, dynamic>> document) {
                final data = document;
                return Module.fromFirestore(data);
              }).toList();
              Provider.of<UserAPI>(context, listen: false).setModules(modules);
            } else {
              hasData = false;
              Provider.of<UserAPI>(context, listen: false).setModules([]);
            }

            return Container(
              constraints: BoxConstraints.expand(),
              child: Consumer<UserAPI>(
                builder: (context, modules, child) {
                  return ListView.builder(
                    //  / reverse: true,
                    controller: widget.scrollController,
                    shrinkWrap: true,
                    itemCount: Provider.of<UserAPI>(context, listen: false)
                        .modules
                        .length, // for the done , module, credits, grade header at index 0
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        //TODO: Might need to fix some things because adding another index.
                        //return Container();
                        return GPATrend();
                      }
                      if (index == 1) {
                        //TODO: Might need to fix some things because adding another index.
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: FilterChips((value) {
                            Provider.of<UserAPI>(context, listen: false)
                                .changeAys(value);
                          }),
                        );
                      }
                      if (index == 2) {
                        return Column(children: <Widget>[
                          Container(
                            color: ModuleTileColor,
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              leading: Padding(
                                padding: EdgeInsets.only(top: 3, left: 7.0),
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
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  ),
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
                      if (hasData) {
                        return Container(
                          child: ModuleTile(
                            index: index,
                            module: Provider.of<UserAPI>(context, listen: false)
                                .modules[index],
                            key: ValueKey(
                                Provider.of<UserAPI>(context, listen: false)
                                    .modules[index]
                                    .id),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                            height: 300,
                            child: Center(
                                child: Text(
                                    "Loading...")), //TODO: make this look better
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    ]);
  }
}

// class GradesList extends StatelessWidget {
// const GradesList({
//   Key? key,
//   required this.scrollController,
// }) : super(key: key);

// final ScrollController scrollController;
// String ays = "2021 S1";

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Expanded(
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//             stream: Provider.of<UserAPI>(context, listen: false)
//                 .findModulesBySemester(
//                     "2021 S1"), //TODO: PUT MAP OF YEAR AND SEM FROM FILTER CHIPS
//             builder: (context, snapshot) {
//               if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//                 final modules = snapshot.data!.docs
//                     .map((DocumentSnapshot<Map<String, dynamic>> document) {
//                   final data = document;
//                   return Module.fromFirestore(data);
//                 }).toList();
//                 print('modules');
//                 print(modules);
//                 Provider.of<UserAPI>(context, listen: false)
//                     .setModules(modules);
//                 return Container(
//                   constraints: BoxConstraints.expand(),
//                   child: Consumer<UserAPI>(
//                     builder: (context, modules, child) {
//                       return ListView.builder(
//                         //  / reverse: true,
//                         controller: scrollController,
//                         shrinkWrap: true,
//                         itemCount: Provider.of<UserAPI>(context, listen: false)
//                             .modules
//                             .length, // for the done , module, credits, grade header at index 0
//                         itemBuilder: (context, index) {
//                           if (index == 0) {
//                             //TODO: Might need to fix some things because adding another index.
//                             //return Container();
//                             return GPATrend();
//                           }
//                           if (index == 1) {
//                             //TODO: Might need to fix some things because adding another index.
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: FilterChips((value) {
//                                 return ays = value;
//                               }),
//                             );
//                           }
//                           if (index == 2) {
//                             return Column(children: <Widget>[
//                               Container(
//                                 color: ModuleTileColor,
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 20),
//                                 child: ListTile(
//                                   leading: Padding(
//                                     padding: EdgeInsets.only(top: 3, left: 7.0),
//                                     child: Text(
//                                       'Done',
//                                       textAlign: alignment,
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                   title: Consumer<UserAPI>(
//                                       builder: (context, modulesData, child) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(bottom: 5),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               'Module',
//                                               textAlign: alignment,
//                                               style: TextStyle(
//                                                 color: Colors.white70,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               'Credits',
//                                               textAlign: alignment,
//                                               style: TextStyle(
//                                                 color: Colors.white70,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               'Grade',
//                                               textAlign: alignment,
//                                               style: TextStyle(
//                                                 color: Colors.white70,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                                   contentPadding:
//                                       EdgeInsets.symmetric(horizontal: 20),
//                                   isThreeLine: false,
//                                 ),
//                               ),
//                               Divider(height: 10, thickness: 1),
//                             ]);
//                           }
//                           return Container(
//                             child: ModuleTile(
//                               index: index,
//                               module:
//                                   Provider.of<UserAPI>(context, listen: false)
//                                       .modules[index],
//                               key: ValueKey(
//                                   Provider.of<UserAPI>(context, listen: false)
//                                       .modules[index]
//                                       .id),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 );
//               } else
//                 return Center(
//                   child: Container(
//                     height: 300,
//                     child: Center(child: Text("Loading...")),
//                   ),
//                 );
//             }),
//       ),
//     ]);
//   }
// }
