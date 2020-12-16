import 'package:flutter/material.dart';

class Module {
  Module(
      {@required this.id,
      @required this.name,
      @required this.grade,
      @required this.credits});

  final int id;
  final String name;
  final double grade;
  final int credits;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'grade': this.grade,
      'credits': this.credits
    };
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, credits: $credits}';
  }
}
