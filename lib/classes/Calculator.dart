import 'module.dart';

class Calculator {
  static double futureCAP(List<Module> mods) {
    double totalFutureGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (!mod.done) {
        totalFutureGrade += mod.grade * mod.credits;
        totalCredits += mod.credits;
      }
    }
    return totalFutureGrade / totalCredits;
  }

  static double currentCAP(List<Module> mods) {
    double totalCurrentGrade = 0;
    double totalCredits = 0;
    for (Module mod in mods) {
      if (mod.done) {
        totalCurrentGrade += mod.grade * mod.credits;
        totalCredits += mod.credits;
      }
    }
    return totalCurrentGrade / totalCredits;
  }

  static double totalCAP(List<Module> mods) {
    //total CAP is calculated
    // Fix this: Runs many times each edit
    double totalGrade = 0;
    int totalCredits = 0;
    for (Module mod in mods) {
      totalGrade += mod.grade * mod.credits;
      totalCredits += mod.credits;
    }
    return totalGrade / totalCredits;
  }

  static int increaseCAP(double cap, double goalCAP) {
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
