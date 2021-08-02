import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/Feedback.dart';
import 'package:gradis/services/SearchAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradis/classes/module.dart';

Future<dynamic> buildSearchPage(BuildContext context, bool hasData) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: ModuleTileColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: Provider.of<SearchAPI>(context, listen: false)
                    .findAllModules(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final modules = snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> document) {
                      final data = document;
                      return Module.fromFirestore(data);
                    }).toList();
                    var uniqueModuleNames =
                        modules.map((module) => module.name).toSet();
                    modules.retainWhere(
                        (module) => uniqueModuleNames.remove(module.name));
                    Provider.of<SearchAPI>(context, listen: false)
                        .setModules(modules);
                  } else {
                    Provider.of<SearchAPI>(context, listen: false)
                        .setModules([]);
                  }
                  print(Provider.of<SearchAPI>(context, listen: false)
                      .allModules);
                  return Column(mainAxisSize: MainAxisSize.min, children: <
                      Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 8 / 12,
                      child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            print(
                                value); //TODO: SEARCH API: Probably need a new SearchAPI.dart file. then we can do Provider.of<SearchAPI>(context, listen: false).search(value). then this should
                            //TODO: return like a list of modules that match. If value = "" then match everything
                            //TODO: So here we keep calling that search function.

                            if (value != '') {
                              Provider.of<SearchAPI>(context, listen: false)
                                  .setResults(Provider.of<SearchAPI>(context,
                                          listen: false)
                                      .allModules
                                      .where((a) => a.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList());
                            } else {
                              Provider.of<SearchAPI>(context, listen: false)
                                  .setResults(Provider.of<SearchAPI>(context,
                                          listen: false)
                                      .allModules);
                              print('results' +
                                  Provider.of<SearchAPI>(context, listen: false)
                                      .results
                                      .toString());
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter Module')),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                        color: ModuleTileColor,
                        height: MediaQuery.of(context).size.height * 4.7 / 12,
                        width: MediaQuery.of(context).size.width * 7 / 12,
                        child: Consumer<SearchAPI>(
                            builder: (context, modules, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                Provider.of<SearchAPI>(context, listen: false)
                                    .results
                                    .length,
                            itemBuilder: (context, index) {
                              if (hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Highlight,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        splashColor: DarkCharcoal,
                                        onTap: () {
                                          buildFeedbackBottomSheet(
                                              context,
                                              Provider.of<SearchAPI>(context,
                                                      listen: false)
                                                  .results[index]);
                                        },
                                        child: SizedBox(
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                                Provider.of<SearchAPI>(context,
                                                        listen: false)
                                                    .results[index]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        )),
                                  ),
                                );
                              }
                              return Container(
                                  child: Center(
                                      child: Text("No Modules in System")));
                            },
                          );
                        }))
                  ]);
                }));
      });
}
