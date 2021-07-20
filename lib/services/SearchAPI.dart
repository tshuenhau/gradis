import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/screens/WelcomeScreen.dart';
import 'package:gradis/screens/InputPage.dart';
import 'package:gradis/classes/module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchAPI extends ChangeNotifier {
  List<Module> allModules = [];
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> findAllModules() {
    return _firestore
        .collection("modules")
        .orderBy("name", descending: false)
        .snapshots();
  }

  setModules(List<Module> mods) {
    allModules = mods;
  }
}
