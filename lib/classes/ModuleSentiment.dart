import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleSentiment {
  String? id;
  String modId;
  String name;
  int workload;
  int difficulty;
  String ays;
  bool su;
  bool done;
  String user;

  ModuleSentiment(
      {this.id,
      required this.modId,
      required this.name,
      required this.workload,
      required this.difficulty,
      required this.ays,
      required this.su,
      required this.done,
      required this.user});

  factory ModuleSentiment.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return ModuleSentiment(
        id: doc.id,
        modId: data['modId'],
        name: data['name'],
        workload: data['workload'],
        difficulty: data['difficulty'],
        ays: data['ays'],
        su: data['su'],
        done: data['done'],
        user: data['user']);
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
