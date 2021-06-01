import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleSentiment {
  String? id;
  String name;
  int workload;
  int difficulty;
  Map ays;
  bool su;
  bool done;

  ModuleSentiment({
    this.id,
    required this.name,
    required this.workload,
    required this.difficulty,
    required this.ays,
    required this.su,
    required this.done,
  });

  factory ModuleSentiment.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return ModuleSentiment(
        id: doc.id,
        name: data['name'],
        workload: data['workload'],
        difficulty: data['difficulty'],
        ays: data['ays'],
        su: data['su'],
        done: data['done']);
  }
  String? getID() {
    return id;
  }

  int getWorkload() {
    return workload;
  }

  int getDifficulty() {
    return difficulty;
  }

  @override
  String toString() {
    return 'SentimentModule{id: $id, name: $name, workload: $workload, difficulty: $difficulty, done: $done, su: $su';
  }
}
