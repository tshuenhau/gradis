import 'package:flutter/material.dart';
import 'package:gradis/classes/goalcap.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
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
            Provider.of<ModulesData>(context, listen: false).addModule(module);
          }),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gradis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(children: <Widget>[
        ListTile(
          tileColor: RaisinBlack,
          leading: Text(
            'Done',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          title: Consumer<ModulesData>(builder: (context, modulesData, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Module',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Credits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Grade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          }),
          trailing: Icon(
              Icons.arrow_drop_up,
              color:Colors.green
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          isThreeLine: false,
        ),
        Expanded(
          child: FutureBuilder<List<Module>>(
              future: Provider.of<ModulesData>(context).dbModules,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    constraints: BoxConstraints.expand(),
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
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: FutureBuilder<List<Module>>(
            future: Provider.of<ModulesData>(context).dbModules,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<ModulesData>(
                    builder: (context, modulesData, child) {
                  Provider.of<ModulesData>(context, listen: false)
                      .calculateCurrentCAP();
                  return Container(
                    color: RaisinBlack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            "total CAP: " +
                                Provider.of<ModulesData>(context, listen: false)
                                    .calculateTotalCAP()
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "current CAP: " +
                                Provider.of<ModulesData>(context, listen: false)
                                    .calculateCurrentCAP()
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "future CAP: " +
                                Provider.of<ModulesData>(context, listen: false)
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
                                  initialText: Provider.of<ModulesData>(context,
                                          listen: false)
                                      .goal
                                      .toStringAsFixed(2),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              } else {
                return Text("");
              }
            }),
      ),
    );
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
        width: 50,
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onSubmitted: (newValue) {
            setState(() {
              text = newValue == ''
                  ? '0.00'
                  : double.parse(newValue).toStringAsFixed(2);
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
