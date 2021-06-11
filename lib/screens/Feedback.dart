import 'package:flutter/material.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:gradis/widgets/DifficultyChart.dart';
import 'package:gradis/widgets/WorkloadChart.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/classes/ModuleSentiment.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/services/SentimentAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> buildFeedbackBottomSheet(
    BuildContext context, ModuleTile widget) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Feedback(widget: widget);
      });
}

class Feedback extends StatefulWidget {
  const Feedback({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ModuleTile widget;

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  double workLoad = 0;
  double difficulty = 0;
  bool isEdit = false;

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
              child: StreamBuilder<ModuleSentiment>(
                stream: Provider.of<SentimentAPI>(context, listen: false)
                    .findOneModuleSentiment(widget.widget.module.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData && !isEdit) {
                    difficulty = snapshot.data!.difficulty.toDouble();
                    workLoad = snapshot.data!.workload.toDouble();
                    isEdit = true;
                  }
                  return Form(
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
                            max: 25,
                            divisions: 25,
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
                            max: 10,
                            divisions: 10,
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
                                Module module = widget.widget.module;
                                ModuleSentiment sentiment = new ModuleSentiment(
                                    id: snapshot.hasData
                                        ? snapshot.data!.id
                                        : "",
                                    name: module.name,
                                    ays: module.ays,
                                    done: module.done,
                                    difficulty: difficulty.floor(),
                                    workload: workLoad.floor(),
                                    su: module.su);
                                // if (_formKey.currentState!.validate()) {
                                //   // Process data.
                                if (!isEdit) {
                                  Provider.of<SentimentAPI>(context,
                                          listen: false)
                                      .createModuleSentiment(sentiment);
                                } else {
                                  Provider.of<SentimentAPI>(context,
                                          listen: false)
                                      .updateModuleSentiment(sentiment);
                                }

                                // }
                              },
                              child: Text(isEdit ? 'Edit' : 'Submit',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
