import 'package:cloud_firestore/cloud_firestore.dart';

class Module {
  Module(
      {this.id,
      required this.name,
      required this.grade,
      required this.credits,
      required this.workload,
      required this.difficulty,
      required this.ays,
      required this.su,
      required this.done,
      this.createdAt});
  final String? id;
  final String name;
  final double grade;
  final int credits;
  final int workload;
  final int difficulty;
  final Timestamp? createdAt;
  final Map ays;
  bool su;
  bool done;

  static Module CreateEmptyModule() {
    return Module(
      id: "empty",
      name: "empty",
      grade: 0,
      credits: 0,
      workload: 0,
      difficulty: 0,
      ays: Map(),
      su: false,
      done: false,
    );
  }

  factory Module.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Module(
        id: doc.id,
        name: data['name'],
        grade: data['grade'],
        credits: data['credits'],
        workload: data['workload'],
        difficulty: data['difficulty'],
        ays: data['ays'],
        su: data['su'],
        done: data['done'],
        createdAt: data['createdAt']);
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, credits: $credits,'
        ' workload: $workload, difficulty: $difficulty, done: $done, su: $su, createdAt: $createdAt}';
  }
}
