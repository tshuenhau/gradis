import 'package:flutter/material.dart';
import 'module.dart';

class Calculator {
  double goalCAP;
  Calculator({@required this.goalCAP});

  double cap(List<Module> mods) {
    double totalGrade;
    int completedModsCounter;
    for (Module mod in mods) {
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
    return goalCAP > cap;
  }
}
