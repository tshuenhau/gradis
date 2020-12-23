import 'package:flutter/material.dart';
import 'module.dart';

class Calculator {
  double goalCAP;
  Calculator({@required this.goalCAP});

  double futureCap(List<Module> mods) {
    double totalFutureGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (!mod.done) {
        totalGrade += mod.grade;
        totalCredits += mod.credits;
      }
    }
    return totalFutureGrade / totalCredits
  }

  double currentCAP(List<Modules> mods) {
    double totalCurrentGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (mod.done) {
        totalGrade += mod.grade;
        totalCredits += mod.credits;
      }
    }
  }

  double totalCAP(List<Modules> mods) {
    double totalGrade = 0;
    int totalCredits = 0;
    for (Module mod in mods) {
      totalGrade += mod.grade;
      totalCredits += mod.credits;
    }
    return totalGrade / totalCredits;
  }

  bool increaseCAP(double cap) {
    return goalCAP > cap;
  }

  double capDiffIfSU (Int totalMCs, Int grade, Int credits, double goalCAP){
    //positive means CAP increase if SU, negative means CAP decrease if SU
    double totalPoints = goalCAP * totalMCs;
    double pointsWithoutSU = (totalMCs - credits) * goalCAP + (credits * grade);
    return (totalPoints - pointsWithoutSU) / totalMCs
  }
}
