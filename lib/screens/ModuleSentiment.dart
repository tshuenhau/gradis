import 'package:flutter/material.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:gradis/widgets/DifficultyChart.dart';
import 'package:gradis/widgets/WorkloadChart.dart';

import 'package:gradis/constants.dart';

double workLoad = 0;
double difficulty = 0;

Future<dynamic> buildModuleSentimentBottomSheet(
    BuildContext context, ModuleTile widget) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return ModuleSentiment(widget: widget);
      });
}

class ModuleSentiment extends StatefulWidget {
  const ModuleSentiment({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ModuleTile widget;

  @override
  _ModuleSentimentState createState() => _ModuleSentimentState();
}

class _ModuleSentimentState extends State<ModuleSentiment> {
  @override
  Widget build(BuildContext context) {
    //return SimpleBarChart();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Container(
      height: MediaQuery.of(context).size.height * (10.35 / 12),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: ModuleTileColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: ListView(
        children: <Widget>[
          Center(
              child: Text(
            widget.widget.module.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )),
          WorkloadChart(),
          DifficultyChart(),
          Text("Word Cloud"),
          Card(
              elevation: 7.0,
              color: ModuleTileColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Your Sentiment",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Workload (Hrs/Week)"),
                      Slider(
                        activeColor: Highlight,
                        inactiveColor: BlueAccent,
                        value: workLoad,
                        min: 0,
                        max: 100,
                        divisions: 101,
                        label: workLoad.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            workLoad = value;
                          });
                        },
                      ),
                      Text("Difficulty"),
                      Slider(
                        activeColor: Highlight,
                        inactiveColor: BlueAccent,
                        value: difficulty,
                        min: 0,
                        max: 100,
                        divisions: 101,
                        label: difficulty.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            difficulty = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                          ),
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                            }
                          },
                          child: const Text('Submit',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
