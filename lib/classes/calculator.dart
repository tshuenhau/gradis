import 'package:flutter/material.dart';
import 'module.dart';

class Calculator {
  double goalCAP;
  Calculator({@required this.goalCAP});

  double cap(List<Module> mods) {
    double totalGrade = 0;
    int completedModsCounter= 0;
    for (Module mod in mods) {
      
        totalGrade += mod.grade;
        completedModsCounter += 1;
    }
    return totalGrade / completedModsCounter;
  }

  bool increaseCAP(double cap) {
    return goalCAP > cap;
  }
}
