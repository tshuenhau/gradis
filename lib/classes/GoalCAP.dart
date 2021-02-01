import 'package:flutter/material.dart';

class GoalCAP {
  double _goal;
  int _id = 0;

  GoalCAP({@required goal}) : _goal = goal;

  Map<String, dynamic> toMap() {
    return {
      'id': this._id,
      'goal': this._goal,
    };
  }

  double getGoalCap() {
    return this._goal;
  }

  int getGoalCapId() {
    return this._id;
  }

  @override
  String toString() {
    return 'Module{id: $_id,  goal: $_goal}';
  }
}
