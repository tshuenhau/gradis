import 'package:flutter/material.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:gradis/widgets/DifficultyChart.dart';
import 'package:gradis/widgets/WorkloadChart.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/classes/ModuleSentiment.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/services/SentimentAPI.dart';
import 'package:gradis/services/GlobalSentimentAPI.dart';
import 'package:gradis/services/ForumAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/classes/Comment.dart';
import 'package:gradis/screens/AddComments.dart';

Future<dynamic> buildFeedbackBottomSheet(BuildContext context, Module module) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Feedback(module: module);
      });
}

class Feedback extends StatefulWidget {
  const Feedback({
    Key? key,
    required this.module,
  }) : super(key: key);

  final Module module;

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  double workLoad = 0;
  double difficulty = 0;
  bool isEdit = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Provider.of<GlobalSentimentAPI>(context, listen: false).setSentiment([]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return SimpleBarChart();
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
            widget.module.name, //!
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: Provider.of<GlobalSentimentAPI>(context, listen: false)
                .getModuleSentiment(widget.module.name), //!
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final moduleSentiments = snapshot.data!.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> document) {
                  final data = document;
                  return ModuleSentiment.fromFirestore(data);
                }).toList();

                Provider.of<GlobalSentimentAPI>(context, listen: false)
                    .setSentiment(moduleSentiments);

                print('module sentiments: ' +
                    Provider.of<GlobalSentimentAPI>(context, listen: false)
                        .sentList
                        .toString());
              }
              Map<int, double> difficultyMap =
                  Provider.of<GlobalSentimentAPI>(context, listen: false)
                      .getDifficultyMap();
              Map<int, double> workloadMap =
                  Provider.of<GlobalSentimentAPI>(context, listen: false)
                      .getWorkloadMap();
              return Column(
                children: <Widget>[
                  WorkloadChart(workloadMap),
                  DifficultyChart(difficultyMap)
                ],
              );
            },
          ),
          Card(
            elevation: 7.0,
            color: ModuleTileColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: StreamBuilder<ModuleSentiment>(
              stream: Provider.of<SentimentAPI>(context, listen: false)
                  .findOneModuleSentiment(widget.module.id!), //!
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
                              Module module = widget.module; //!
                              ModuleSentiment sentiment = new ModuleSentiment(
                                  id: snapshot.hasData ? snapshot.data!.id : "",
                                  modId: module.id!,
                                  name: module.name,
                                  ays: module.ays,
                                  done: module.done,
                                  difficulty: difficulty.floor(),
                                  workload: workLoad.floor(),
                                  su: module.su,
                                  user: _auth.currentUser!.uid);
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
            ),
          ),
          Card(
            elevation: 7.0,
            color: ModuleTileColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(children: <Widget>[
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: Provider.of<ForumAPI>(context, listen: false)
                    .findAllComments(widget.module.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final comments = snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> document) {
                      final data = document;
                      return Comment.fromFirestore(data);
                    }).toList();
                    Provider.of<ForumAPI>(context, listen: false)
                        .setComments(comments);
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Center(
                            child: Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount:
                                Provider.of<ForumAPI>(context, listen: false)
                                    .comments
                                    .length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: ModuleTileColor,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: ModuleTileColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: BlueAccent,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Text('Semester: ' +
                                          Provider.of<ForumAPI>(context,
                                                  listen: false)
                                              .comments[index]
                                              .ays),
                                      SizedBox(height: 10),
                                      Text('Workload: ' +
                                          Provider.of<ForumAPI>(context,
                                                  listen: false)
                                              .comments[index]
                                              .workload
                                              .floor()
                                              .toString() +
                                          ' Difficulty: ' +
                                          Provider.of<ForumAPI>(context,
                                                  listen: false)
                                              .comments[index]
                                              .difficulty
                                              .floor()
                                              .toString()),
                                      SizedBox(height: 10),
                                      Text(Provider.of<ForumAPI>(context,
                                              listen: false)
                                          .comments[index]
                                          .comment),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container(
                        child: Center(
                      child: Text("No comments",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70)),
                    ));
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                ),
                onPressed: () {
                  //TODO: add popup to add comments
                  buildCommentsBottomSheet(
                      context, widget.module, workLoad, difficulty);
                },
                child: Center(
                  child: Text("Add Comment",
                      style: TextStyle(color: Colors.black)),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
