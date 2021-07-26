import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment(
      {this.id,
      required this.name,
      required this.module,
      required this.comment,
      required this.workload,
      required this.difficulty,
      required this.ays,
      required this.likes,
      required this.dislikes,
      this.createdAt});
  final String? id;
  final String name;
  final String module;
  final String comment;
  final int workload;
  final int difficulty;
  final int likes;
  final int dislikes;
  final Timestamp? createdAt;
  final String ays;

  factory Comment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Comment(
      id: doc.id,
      name: data['name'],
      module: data['module'],
      comment: data['comment'],
      workload: data['workload'],
      difficulty: data['difficulty'],
      likes: data['likes'],
      dislikes: data['dislikes'],
      ays: data['ays'],
      createdAt: data['createdAt'],
    );
  }

  String? getID() {
    return id;
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, module: $module, comment: $comment,'
        ' workload: $workload, difficulty: $difficulty, ays: $ays, createdAt: $createdAt}';
  }
}
