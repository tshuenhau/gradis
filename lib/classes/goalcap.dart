import 'package:flutter/material.dart';

class GoalCAP {
  double goal;
  int id = 0;
  GoalCAP({this.id, @required this.goal});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'goal': this.goal,
    };
  }

  @override
  String toString() {
    return 'Module{id: $id,  goal: $goal}';
  }
}
