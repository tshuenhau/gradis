import 'package:flutter/material.dart';
import 'module.dart';

class Calculator {
  double goalCAP;
  Calculator({@required this.goalCAP});

  double futureCap(List<Module> mods) {
    double totalFutureGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (mod.done == 0) {
        totalFutureGrade += mod.grade * mod.credits;
        totalCredits += mod.credits;
      }
    }
    return totalFutureGrade / totalCredits;
  }

  double currentCAP(List<Module> mods) {
    double totalCurrentGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (mod.done == 1) {
        totalCurrentGrade += mod.grade * mod.credits;
        totalCredits += mod.credits;
      }
    }
    return totalCurrentGrade / totalCredits;
  }

  double totalCAP(List<Module> mods) {
    double totalGrade = 0;
    int totalCredits = 0;
    for (Module mod in mods) {
      totalGrade += mod.grade * mod.credits;
      totalCredits += mod.credits;
    }
    return totalGrade / totalCredits;
  }

  int increaseCAP(double cap) {
    //1: increase CAP, -1: decrease CAP, 0: CAP same
    return cap < goalCAP
        ? 1
        : cap > goalCAP
            ? -1
            : 0;
  }

  double capDiffIfSU(int totalMCs, double grade, int credits, double goalCAP) {
    //positive means CAP increase if SU, negative means CAP decrease if SU
    double totalPoints = goalCAP * totalMCs;
    double pointsWithoutSU = (totalMCs - credits) * goalCAP + (credits * grade);
    return (totalPoints - pointsWithoutSU) / totalMCs;
  }
}
