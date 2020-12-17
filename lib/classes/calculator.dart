import 'package:flutter/material.dart';
import 'module.dart';

class Calculator {
  double goalCAP;
  Calculator({@required goalCAP});

  double cap(List<TestModule> mods) {
    double totalGrade;
    int completedModsCounter;
    for (TestModule mod in mods) {
      if (mod.done) {
        totalGrade += mod.grade;
        completedModsCounter += 1;
      } else {
        continue;
      }
    }
    return totalGrade / completedModsCounter;
  }

  bool increaseCAP(double cap) {
    return goalCAP < cap;
  }
}

class TestModule {
  TestModule(
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

List<TestModule> modules = [
  TestModule(name: 'CS1231', grade: 4, credits: 4),
  TestModule(name: 'CS1101S', grade: 4, credits: 4),
  TestModule(name: 'IS1103', grade: 3, credits: 4),
  TestModule(name: 'MA1101R', grade: 4, credits: 4),
  TestModule(name: 'ST1131', grade: 4, credits: 4)
]; // create dummy data to test
