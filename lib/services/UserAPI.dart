import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradis/classes/module.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/classes/Calculator.dart';
import 'package:gradis/classes/GoalCAP.dart';

class UserAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late List<Module> modules = [];
  double goalCAP = 0;

  void setModules(List<Module> modules) {
    this.modules = modules;
    this.modules.insert(0, Module.createEmptyModule());
    this.modules.insert(1, Module.createEmptyModule());
    this.modules.insert(2, Module.createEmptyModule());
  }

  int numOfModules() {
    return this.modules.length;
  }

  void createModule(Module mod) {
    _firestore
        .collection('modules')
        .add({
          'name': mod.name,
          'credits': mod.credits,
          'grade': mod.grade,
          'workload': mod.workload,
          'difficulty': mod.difficulty,
          'ays': mod.ays,
          'su': mod.su,
          'user': _auth.currentUser!.uid,
          'done': mod.done,
          'createdAt': FieldValue.serverTimestamp()
        })
        .then((value) => print("Module created: $mod"))
        .catchError((error) => print("Failed to add module: $error"));
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findAllModules() {
    return _firestore
        .collection("modules")
        .where('user', isEqualTo: _auth.currentUser!.uid)
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findModulesBySemester(int ays) {
    return _firestore
        .collection('modules')
        .orderBy("createdAt", descending: false)
        .where('ays', isEqualTo: ays)
        .where('user', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

  updateModule(Module mod, String? id) {
    if (id == null) {
      print('no id given!');
      return;
    }
    _firestore
        .collection('modules')
        .doc(id)
        .update({
          'name': mod.name,
          'credits': mod.credits,
          'grade': mod.grade,
          'workload': mod.workload,
          'difficulty': mod.difficulty,
          'ays': mod.ays,
          'su': mod.su,
          'user': _auth.currentUser!.uid,
          'done': mod.done,
          'createdAt': mod.createdAt
        })
        .then((value) => print("Module updated: $mod"))
        .catchError((error) => print("Failed to update module: $error"));
    notifyListeners();
  }

  void deleteModule(Module module) {
    _firestore
        .collection('modules')
        .doc(module.getID())
        .delete()
        .then((value) => print("Module Deleted"))
        .catchError((error) => print("Failed to delete module: $error"));
    notifyListeners();
  }

  void setGoalCAP(GoalCAP goalCAP) {
    this.goalCAP = goalCAP.goal;
  }

  Stream<GoalCAP> findGoalCAP() {
    return _firestore
        .collection('goalCAP')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((snap) => GoalCAP.fromFirestore(snap));
  }

  void updateGoalCAP(double goalCAP, String id) {
    if (id == 'first-creation') {
      _firestore
          .collection('goalCAP')
          .add({'CAP': goalCAP, 'user': _auth.currentUser!.uid});
    } else {
      _firestore
          .collection('goalCAP')
          .doc(id)
          .update({'CAP': goalCAP})
          .then((value) => print("Goal CAP updated: " + goalCAP.toString()))
          .catchError((error) => print("Failed to update goal CAP: $error"));
    }
    notifyListeners();
  }

  void deleteGoalCAP(GoalCAP goalCAP) {
    _firestore
        .collection('goalCAP')
        .doc(goalCAP.id)
        .delete()
        .then((value) => print("Goal CAP Deleted"))
        .catchError((error) => print("Failed to delete goal CAP: $error"));
    notifyListeners();
  }

  double calculateCurrentCAP() {
    return Calculator.currentCAP(modules);
  }

  double calculateTotalCAP() {
    return Calculator.totalCAP(modules);
  }

  double calculateFutureCAP() {
    return Calculator.futureCAP(modules);
  }
}
