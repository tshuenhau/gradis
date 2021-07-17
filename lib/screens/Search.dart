import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/Feedback.dart';

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
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 8 / 12,
                child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      print(
                          value); //TODO: SEARCH API: Probably need a new SearchAPI.dart file. then we can do Provider.of<SearchAPI>(context, listen: false).search(value). then this should
                      //TODO: return like a list of modules that match. If value = "" then match everything
                      //TODO: So here we keep calling that search function.
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
                  child: Consumer<UserAPI>(builder: (context, modules, child) {
                    //TODO: HERE WE NEED TO API CALL TO GET ALL MODULES
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: Provider.of<UserAPI>(context, listen: false)
                          .modules
                          .length, // TODO: replace with new API
                      itemBuilder: (context, index) {
                        if (hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Highlight,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: DarkCharcoal,
                                  onTap: () => {
                                        buildFeedbackBottomSheet(
                                            context,
                                            Provider.of<UserAPI>(
                                                    context, // TODO: replace with new API
                                                    listen: false)
                                                .modules[index])
                                      },
                                  child: SizedBox(
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                          Provider.of<UserAPI>(context,
                                                  listen: false)
                                              .modules[index]
                                              .name
                                              .toString(), // TODO: replace with new API
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  )),
                            ),
                          );
                        }
                        return Container(
                            child: Center(child: Text("No Modules in System")));
                      },
                    );
                  }))
            ]));
      });
}
