import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/classes/ModuleSentiment.dart';
import 'package:gradis/classes/Calculator.dart';

class GlobalSentimentAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  int maxDiff = 10;
  int maxWorkload = 25;
  List<ModuleSentiment> sentList = [];
  Map<int, double> difficultyMap = {};
  Map<int, double> workloadMap = {};

  Stream<QuerySnapshot<Map<String, dynamic>>> getModuleSentiment(
      String module) {
    return _firestore
        .collection('sentiment')
        .where('name', isEqualTo: module)
        .snapshots();
  }

  Map<int, double> getDifficultyMap() {
    List<int> list = [for (var i = 0; i <= maxDiff; i += 1) i];
    Map<int, double> diffMap = Map<int, double>.fromIterable(list,
        key: (item) => item, value: (item) => 0);
    sentList.forEach((sent) {
      diffMap.update(sent.difficulty, (value) => value + 1);
    });
    return diffMap;
  }

  Map<int, double> getWorkloadMap() {
    //TODO: What happens when you delete a module?
    List<int> list = [for (var i = 0; i <= maxWorkload; i += 1) i];

    Map<int, double> workloadMap = Map<int, double>.fromIterable(list,
        key: (item) => item, value: (item) => 0);
    sentList.forEach(
        (sent) => {workloadMap.update(sent.workload, (value) => value + 1)});
    return workloadMap;
  }

  void setSentiment(List<ModuleSentiment> sentList) {
    this.sentList = sentList;
  }

  int calculateWorkLoad(List<ModuleSentiment> mods) {
    return Calculator.calculateWorkload(mods);
  }

  int calculateDifficulty(List<ModuleSentiment> mods) {
    return Calculator.calculateDifficulty(mods);
  }
}
