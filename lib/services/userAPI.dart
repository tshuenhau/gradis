import 'package:flutter/cupertino.dart';
import 'package:gradis/classes/module.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createModule(Module mod) {
    _firestore.collection('modules').add({
      'name': mod.name,
      'credits': mod.credits,
      'grade': mod.grade,
      'workload': mod.workload,
      'difficulty': mod.difficulty,
      'ays': mod.ays,
      'sender': _auth.currentUser,
      'done': mod.isDone()
    });
  }

  findModulesBySemester(int ays) async {
    return await _firestore
        .collection('modules')
        .where('ays', isEqualTo: ays)
        .where('user', isEqualTo: _auth.currentUser)
        .get();
  }

  findGoalCAP() async {
    return await _firestore
        .collection('goalCAP')
        .where('user', isEqualTo: _auth.currentUser)
        .get();
  }

  updateModule(Module mod, String id) async {
    return _firestore
        .collection('module')
        .doc(id)
        .update({
          'name': mod.name,
          'credits': mod.credits,
          'grade': mod.grade,
          'workload': mod.workload,
          'difficulty': mod.difficulty,
          'ays': mod.ays,
          'sender': _auth.currentUser,
          'done': mod.isDone()
        })
        .then((value) => print("Module updated"))
        .catchError((error) => print("Failed to update module: $error"));
  }

  updateGoalCAP(double goalCAP, String id) {
    return _firestore
        .collection('GoalCAP')
        .doc(id)
        .update({'CAP': goalCAP})
        .then((value) => print("Goal CAP updated"))
        .catchError((error) => print("Failed to update goal CAP: $error"));
  }

  deleteModule(String id) {
    return _firestore
        .collection('module')
        .doc(id)
        .delete()
        .then((value) => print("Module Deleted"))
        .catchError((error) => print("Failed to delete module: $error"));
  }

  deleteGoalCAP(String id) {
    return _firestore
        .collection('GoalCAP')
        .doc(id)
        .delete()
        .then((value) => print("Goal CAP Deleted"))
        .catchError((error) => print("Failed to delete goal CAP: $error"));
  }
}
