import 'package:cloud_firestore/cloud_firestore.dart';

class GoalCAP {
  double goal;
  String id;

  GoalCAP({required goal, required id})
      : goal = goal,
        id = id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal': goal,
    };
  }

  double getGoalCap() {
    return this.goal;
  }

  String getGoalCapId() {
    return this.id;
  }

  factory GoalCAP.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return GoalCAP(id: doc.id, goal: data['goal']);
  }

  @override
  String toString() {
    return 'Module{id: $id,  goal: $goal}';
  }
}
