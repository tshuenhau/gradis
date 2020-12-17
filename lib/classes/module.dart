import 'package:flutter/material.dart';

class Module {
  Module(
      {this.id,
      @required this.name,
      @required this.grade,
      @required this.credits,
      this.done});

  int id = 0;
  final String name;
  final double grade;
  final int credits;
  bool done = false;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'grade': this.grade,
      'credits': this.credits,
      'done': this.done
    };
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, credits: $credits, done: $done}';
  }
}
