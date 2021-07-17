import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/Settings.dart';
import 'package:gradis/widgets/ModuleTile.dart';

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
    bool hasData = true;

    return BottomAppBar(
      color: PrimaryColor,
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: MediaQuery.of(context).size.height / 15,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                color: IconsColor,
                onPressed: () {
                  showModalBottomSheet(
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
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        8 /
                                        12,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          goal = double.parse(value);
                                        },
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                                hintText: 'Enter Module')),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Container(
                                      color: ModuleTileColor,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              4.7 /
                                              12,
                                      width: MediaQuery.of(context).size.width *
                                          7 /
                                          12,
                                      child: Consumer<UserAPI>(
                                          builder: (context, modules, child) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: Provider.of<UserAPI>(
                                                  context,
                                                  listen: false)
                                              .modules
                                              .length,
                                          itemBuilder: (context, index) {
                                            if (hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Highlight,
                                                  child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      splashColor: DarkCharcoal,
                                                      onTap: () => {
                                                            print(Provider.of<
                                                                        UserAPI>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .modules[index]
                                                                .name
                                                                .toString())
                                                          },
                                                      child: SizedBox(
                                                        height: 45,
                                                        child: Center(
                                                          child: Text(
                                                              Provider.of<UserAPI>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .modules[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                      )),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }))
                                ]));
                      });
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
                  buildSettingsBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
