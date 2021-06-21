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
  GoalCAP? goalCAP;
  late String ays = "All";
  late List<Module> allModules = [];
  late List<Module> doneMods = [];

  void setModules(List<Module> modules) {
    this.modules = modules;
    this.modules.insert(0, Module.createEmptyModule());
    this.modules.insert(1, Module.createEmptyModule());
    this.modules.insert(2, Module.createEmptyModule());
  }

  void setAllModules(List<Module> modules) {
    this.allModules = modules;
    this.allModules.insert(0, Module.createEmptyModule());
    this.allModules.insert(1, Module.createEmptyModule());
    this.allModules.insert(2, Module.createEmptyModule());
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

  // Stream<String> findAllAysWithDoneMods() {
  //   _firestore.collection('modules').where('user', isEqualTo: '_auth.currentUser!.uid').where('done', isEqualTo: true).snapshots().
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> findAllModules() {
    return _firestore
        .collection("modules")
        .where('user', isEqualTo: _auth.currentUser!.uid)
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findModulesBySemester(
      String ays) {
    if (ays == "All") {
      return findAllModules();
    }
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
    this.goalCAP = goalCAP;
  }

  Stream<GoalCAP> findGoalCAP() {
    return _firestore
        .collection('goalCAP')
        .where('user', isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map((snap) {
      print('wat' + snap.docs.toString());
      if (snap.docs.isEmpty) {
        return GoalCAP(id: '', goal: -1.00);
      } else {
        return GoalCAP.fromFirestore(snap.docs[0]);
      }
    });
  }

  void updateGoalCAP(GoalCAP goalGPA) {
    if (goalGPA.id == '') {
      _firestore
          .collection('goalCAP')
          .add({'GPA': goalGPA.goal, 'user': _auth.currentUser!.uid})
          .then((value) => print("Goal GPA added!"))
          .catchError((error) => print("Failed to add goal GPA: $error"));
    } else {
      _firestore
          .collection('goalCAP')
          .doc(goalGPA.id)
          .update({'GPA': goalGPA.goal})
          .then((value) => print("Goal GPA updated: " + goalGPA.toString()))
          .catchError((error) => print("Failed to update goal GPA: $error"));
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

  // double calculateGPABySemester() {
  //   return Calculator.calculateGPABySemester(allModules);
  // }

  void changeAys(String value) {
    this.ays = value;
    notifyListeners();
  }

  void setAllDoneModules() {
    this.doneMods = this.allModules.where((mod) => mod.done).toList();
  }

  List<String> getAllDoneAys() {
    List<String> doneAys = this.doneMods.map((mod) => mod.ays).toSet().toList();
    doneAys.sort();
    return doneAys;
  }

  List<double> calculateDiscreteGPA(List<String> doneAys) {
    List<double> res = [];
    for (String ays in doneAys) {
      double credits = 0;
      double grade = 0;
      for (Module mod in this.doneMods) {
        if (mod.ays == ays) {
          credits += mod.credits;
          grade += mod.grade * mod.credits;
        }
      }
      res.add(grade / credits);
    }
    return res;
  }

  List<double> calculateCumulativeGPA(List<String> doneAys) {
    List<double> res = [];
    double totalCredits = 0;
    double totalGrade = 0;
    for (String ays in doneAys) {
      for (Module mod in this.doneMods) {
        if (mod.ays == ays) {
          totalCredits += mod.credits;
          totalGrade += mod.grade * mod.credits;
        }
      }
      res.add(totalGrade / totalCredits);
    }
    return res;
  }

  // Stream<String> getAllAys() {
  //   return _firestore.collection('AYS').doc(_auth.currentUser!.uid).snapshots().map((snap) => snap.ays);
  // }

}
