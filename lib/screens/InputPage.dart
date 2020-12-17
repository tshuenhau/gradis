import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/screens/AddModules.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';

import '../database.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    Provider.of<ModulesData>(context, listen: false).getModulesFromDB();
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
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(),
                      )));
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
                            height: 300,
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
                  FloatingActionButton(onPressed: () {
                    Provider.of<ModulesData>(context, listen: false)
                        .currentCAP -= 1;
                    print(Provider.of<ModulesData>(context, listen: false)
                        .currentCAP);
                    Provider.of<ModulesData>(context, listen: false).incCAP();
                    print(Provider.of<ModulesData>(context, listen: false)
                        .incCap);
                  })
                ],
              ),
            )
          ],
        ));
  }
}
