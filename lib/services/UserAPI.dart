import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradis/classes/module.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/classes/Calculator.dart';
import 'package:gradis/classes/GoalCAP.dart';

enum Change { increase, decrease, noChange }

class UserAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  static late List<Module> modules = [];
  static double goalCAP = 0;

  static void setModules(List<Module> modules) {
    UserAPI.modules = modules;
    UserAPI.modules.insert(0, Module.CreateEmptyModule());
  }

  void createModule(Module mod) {
    _firestore.collection('modules').add({
      'name': mod.name,
      'credits': mod.credits,
      'grade': mod.grade,
      'workload': mod.workload,
      'difficulty': mod.difficulty,
      'ays': mod.ays,
      'su': mod.su,
      'user': _auth.currentUser?.email,
      'done': mod.done
    });
    notifyListeners();

    print('module create: ' + mod.toString());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findAllModules() {
    return _firestore
        .collection('modules')
        .where('user', isEqualTo: _auth.currentUser?.email)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findModulesBySemester(int ays) {
    return _firestore
        .collection('modules')
        .where('ays', isEqualTo: ays)
        .where('user', isEqualTo: _auth.currentUser?.email)
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
          'user': _auth.currentUser?.email,
          'done': mod.done
        })
        .then((value) => print("Module updated: $mod"))
        .catchError((error) => print("Failed to update module: $error"));
    notifyListeners();
    print('updated module');
  }

  void deleteModule(String id) async {
    await _firestore
        .collection('modules')
        .doc(id)
        .delete()
        .then((value) => print("Module Deleted"))
        .catchError((error) => print("Failed to delete module: $error"));
    notifyListeners();
  }

  static void setGoalCAP(double goalCAP) {
    UserAPI.goalCAP = goalCAP;
  }

  void createGoalCAP(double goalCAP) async {
    _firestore
        .collection('goalCAP')
        .add({'CAP': goalCAP, 'user': _auth.currentUser?.email});
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findGoalCAP() {
    return _firestore
        .collection('goalCAP')
        .where('user', isEqualTo: _auth.currentUser?.email)
        .snapshots();
  }

  void updateGoalCAP(double goalCAP, String id) {
    _firestore
        .collection('goalCAP')
        .doc(id)
        .update({'CAP': goalCAP})
        .then((value) => print("Goal CAP updated: " + goalCAP.toString()))
        .catchError((error) => print("Failed to update goal CAP: $error"));
    notifyListeners();
  }

  void deleteGoalCAP(String id) {
    _firestore
        .collection('goalCAP')
        .doc(id)
        .delete()
        .then((value) => print("Goal CAP Deleted"))
        .catchError((error) => print("Failed to delete goal CAP: $error"));
    notifyListeners();
  }

  int incCAP() {
    return Calculator.increaseCAP(Calculator.totalCAP(modules), goalCAP);
  }

  double calculateCurrentCAP() {
    return Calculator.currentCAP(modules);
  }

  double calculateTotalCAP() {
    // //print("total CAP: " + calculator.totalCAP(modules).toString());
    double totalCAP = Calculator.totalCAP(modules);
    return totalCAP;
  }

  double calculateFutureCAP() {
    // //print("current CAP: " + calculator.totalCAP(modules).toString());
    return Calculator.futureCAP(modules);
  }
}
