import 'package:flutter/material.dart';
import 'package:gradis/classes/goalcap.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/screens/AddModules.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController _controller;
  @override
  void initState() {
    Provider.of<ModulesData>(context, listen: false).getModulesFromDB();
    Provider.of<ModulesData>(context, listen: false).getGoalCAPFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CharlestonGreen,
        floatingActionButton: FloatingActionButton(
            backgroundColor: LightSilver,
            child: Icon(Icons.add),
            onPressed: () {
              final module =
                  Module(id: 0, name: "newmodule", grade: 0, credits: 0);
              Provider.of<ModulesData>(context, listen: false)
                  .addModule(module);
              // showModalBottomSheet(
              //     context: context,
              //     isScrollControlled: true,
              //     builder: (context) => SingleChildScrollView(
              //             child: Container(
              //           padding: EdgeInsets.only(
              //               bottom: MediaQuery.of(context).viewInsets.bottom),
              //           child: AddModulesScreen(),
              //         )));
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 40.0, left: 0, right: 0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Gradis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: RaisinBlack,
                          ),
                          child: Text(
                            'Module',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          'Credits',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Grade',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ]),
                  FutureBuilder<List<Module>>(
                      future: Provider.of<ModulesData>(context).dbModules,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 450,
                            decoration: BoxDecoration(
                              color: CharlestonGreen,
                            ),
                            child: GradesList(),
                          );
                        } else
                          return Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: CharlestonGreen,
                            ),
                            child: Text("Loading"),
                          );
                      }),
                  // FloatingActionButton(onPressed: () {
                  //   Provider.of<ModulesData>(context, listen: false)
                  //       .currentCAP -= 1;
                  //   print("current CAP: " +
                  //       Provider.of<ModulesData>(context, listen: false)
                  //           .currentCAP
                  //           .toString());
                  //   Provider.of<ModulesData>(context, listen: false).incCAP();
                  //   print("current CAP greater than goal CAP: " +
                  //       Provider.of<ModulesData>(context, listen: false)
                  //           .incCap
                  //           .toString());
                  // })
                ],
              ),
            ),
            FutureBuilder<List<Module>>(
                future: Provider.of<ModulesData>(context).dbModules,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<ModulesData>(
                        builder: (context, modulesData, child) {
                      Provider.of<ModulesData>(context, listen: false)
                          .calculateCurrentCAP();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              "total CAP: " +
                                  Provider.of<ModulesData>(context,
                                          listen: false)
                                      .calculateTotalCAP()
                                      .toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "current CAP: " +
                                  Provider.of<ModulesData>(context,
                                          listen: false)
                                      .calculateCurrentCAP()
                                      .toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "future CAP: " +
                                  Provider.of<ModulesData>(context,
                                          listen: false)
                                      .calculateFutureCAP()
                                      .toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Text("goal CAP: "),
                                Expanded(
                                  child: GoalCAPTextField(
                                    initialText:
                                        modulesData.goal.toStringAsFixed(2),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                  } else {
                    return Text("");
                  }
                }),
          ],
        ));
  }
}

//TODO: EDITED HERE
class GoalCAPTextField extends StatefulWidget {
  final String initialText;
  GoalCAPTextField({@required this.initialText});

  @override
  _GoalCAPTextFieldState createState() => _GoalCAPTextFieldState();
}

class _GoalCAPTextFieldState extends State<GoalCAPTextField> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String text;

  @override
  void initState() {
    text = widget.initialText;

    super.initState();
    _editingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditingText) {
      return Container(
        width: 60,
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onSubmitted: (newValue) {
            setState(() {
              text = double.parse(newValue).toStringAsFixed(2);
              _isEditingText = false;
            });
            final newGoal = GoalCAP(goal: double.parse(text));
            Provider.of<ModulesData>(context, listen: false)
                .updateGoalCAP(newGoal);
          },
        ),
      );
    }
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          text != null ? text : "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ));
  }
}
