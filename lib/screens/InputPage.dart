import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';

const TextStyle capTextStyle = TextStyle(
  color: LightSilver,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
const TextStyle titleTextStyle = TextStyle(
  color: LightSilver,
  fontSize: 10.0,
  fontWeight: FontWeight.w400,
);

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
      backgroundColor: Onyx,
      floatingActionButton: FloatingActionButton(
          backgroundColor: LightSilver,
          child: Icon(Icons.add),
          onPressed: () {
            final module = Module(id: 0, name: "new", grade: 0, credits: 0);
            Provider.of<ModulesData>(context, listen: false).addModule(module);
          }),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top:12.0),
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
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Total",
                                      textAlign: TextAlign.left,
                                      style: titleTextStyle,
                                    ),
                                    Text(
                                      Provider.of<ModulesData>(context,
                                              listen: false)
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
                                  children: [
                                    const Text(
                                      "Current",
                                      textAlign: TextAlign.left,
                                      style: titleTextStyle,
                                    ),
                                    Text(
                                      Provider.of<ModulesData>(context,
                                              listen: false)
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
                                    color: LightSilver,
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w700,
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
                                      Provider.of<ModulesData>(context,
                                              listen: false)
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
                                    GoalCAPTextField(
                                        initialText: Provider.of<ModulesData>(
                                                context,
                                                listen: false)
                                            .goalCAP
                                            .toStringAsFixed(2))
                                  ],
                                ),
                              ),
                            ]),
                      );
                    });
                  } else {
                    return Text("");
                  }
                }),
          ),

          // actions: [
          //   Container(
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Row(children: <Widget>[
          //         Column(children: <Widget>[
          //           Text("Total CAP: 4.0"),
          //           Text("Goal CAP: 5.0"),
          //         ]),
          //         Column(children: <Widget>[
          //           Text("Future CAP: 4.0"),
          //           Text("Current CAP: 4.0")
          //         ])
          //       ]),
          //     ),
          //   ),
          // ],
        ),
      ),
      body: Column(children: <Widget>[
        // ListTile(
        //   tileColor: RaisinBlack,
        //   leading: Text(
        //     'Done',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18,
        //     ),
        //   ),
        //   title: Consumer<ModulesData>(builder: (context, modulesData, child) {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Expanded(
        //           child: Text(
        //             'Module',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Text(
        //             'Credits',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Text(
        //             'Grade',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //       ],
        //     );
        //   }),
        //   trailing: Icon(Icons.arrow_drop_up, color: Colors.green),
        //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
        //   isThreeLine: false,
        // ),
        Expanded(
          child: FutureBuilder<List<Module>>(
              future: Provider.of<ModulesData>(context).dbModules,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      color: Onyx,
                    ),
                    child: GradesList(),
                  );
                } else
                  return Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Onyx,
                    ),
                    child: Text("Loading"),
                  );
              }),
        ),
      ]),
    );
  }
}
