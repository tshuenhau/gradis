import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    Provider.of<ModulesData>(context, listen: false).getModules();
    Provider.of<ModulesData>(context, listen: false).getGoalCAP();
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
            color: LightSilver,
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
          trailing: Icon(Icons.arrow_drop_up, color: Colors.green),
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
                                      .goalCAP
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
