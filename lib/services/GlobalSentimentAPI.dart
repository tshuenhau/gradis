import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/classes/Calculator.dart';
import 'package:gradis/classes/module.dart';

class GlobalSentimentAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<int, double>> getModuleSentiment(String module) async {
    Map<int, double> map = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0
    };
    QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection('sentiment')
        .where('name', isEqualTo: module)
        .get();
    response.docs.map((QueryDocumentSnapshot<dynamic> snapshot) => 1);

    return {1: 2};
  }
}
