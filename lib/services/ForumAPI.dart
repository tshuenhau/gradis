import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradis/classes/Comment.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForumAPI extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late List<Comment> comments = [];

  void setComments(List<Comment> comments) {
    this.comments = comments;
  }

  void createComment(Comment com) {
    _firestore
        .collection('comments')
        .add({
          'name': com.name,
          'module': com.module,
          'workload': com.workload,
          'difficulty': com.difficulty,
          'ays': com.ays,
          'user': _auth.currentUser!.uid,
          'likes': com.likes,
          'dislikes': com.dislikes,
          'comment': com.comment,
          'createdAt': FieldValue.serverTimestamp()
        })
        .then((value) => print("Comment created: $com"))
        .catchError((error) => print("Failed to add module: $error"));
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> findAllComments(String module) {
    print('hey hey' + module);
    return _firestore
        .collection("comments")
        .where('module', isEqualTo: module)
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  updateComment(Comment com, String? id) {
    if (id == null) {
      print('no id given!');
      return;
    }
    _firestore
        .collection('modules')
        .doc(id)
        .update({
          'name': com.name,
          'credits': com.module,
          'workload': com.workload,
          'difficulty': com.difficulty,
          'ays': com.ays,
          'user': _auth.currentUser!.uid,
          'likes': com.likes,
          'dislikes': com.dislikes,
          'comment': com.comment,
          'createdAt': com.createdAt
        })
        .then((value) => print("Module updated: $com"))
        .catchError((error) => print("Failed to update module: $error"));
    notifyListeners();
  }

  void deleteModule(Comment com) {
    _firestore
        .collection('modules')
        .doc(com.getID())
        .delete()
        .then((value) => print("Module Deleted"))
        .catchError((error) => print("Failed to delete module: $error"));
    notifyListeners();
  }
}
