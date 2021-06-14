import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradis/classes/ModuleSentiment.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SentimentAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void createModuleSentiment(ModuleSentiment mod) {
    _firestore
        .collection('sentiment')
        .add({
          'name': mod.name,
          'modId': mod.modId,
          'workload': mod.workload,
          'difficulty': mod.difficulty,
          'ays': mod.ays,
          'su': mod.su,
          'user': _auth.currentUser!.uid,
          'done': mod.done
        })
        .then((value) => print("Module sentiment created: $value"))
        .catchError(
            (error) => print("Failed to created module sentiment: $error"));
    notifyListeners();
  }

  void deleleteModuleSentiment(ModuleSentiment mod) {
    _firestore
        .collection('sentiment')
        .doc(mod.getID())
        .delete()
        .then((value) => print("Module sentiment deleted"))
        .catchError(
            (error) => print("Failed to delete module sentiment: $error"));
    notifyListeners();
  }

  void updateModuleSentiment(ModuleSentiment mod) {
    if (mod.getID() == null) {
      print('no id given!');
      return;
    }
    _firestore
        .collection('sentiment')
        .doc(mod.getID())
        .update({
          'name': mod.name,
          'workload': mod.workload,
          'difficulty': mod.difficulty,
          'ays': mod.ays,
          'su': mod.su,
          'user': _auth.currentUser!.uid,
          'done': mod.done
        })
        .then((value) => print("Module sentiment updated: $mod"))
        .catchError(
            (error) => print("Failed to update module sentiment: $error"));
    notifyListeners();
  }

  Stream<ModuleSentiment> findOneModuleSentiment(String moduleId) {
    return _firestore
        .collection('sentiment')
        .where('user', isEqualTo: _auth.currentUser!.uid)
        .where('modId', isEqualTo: moduleId)
        .snapshots()
        .map((snap) => ModuleSentiment.fromFirestore(snap.docs[0]));
  }

  Stream<ModuleSentiment> findAllModuleSentiment() {
    return _firestore
        .collection('sentiment')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((snap) => ModuleSentiment.fromFirestore(snap));
  }
}
