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
  final bool done;

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