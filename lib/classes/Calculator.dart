import 'module.dart';
import 'ModuleSentiment.dart';

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

  double capDiffIfSU(int totalMCs, double grade, int credits, double goalCAP) {
    //Not needed
    //positive means CAP increase if SU, negative means CAP decrease if SU
    double totalPoints = goalCAP * totalMCs;
    double pointsWithoutSU = (totalMCs - credits) * goalCAP + (credits * grade);
    return (totalPoints - pointsWithoutSU) / totalMCs;
  }

  static calculateWorkload(List<ModuleSentiment> mods) {
    int workload = 0;
    for (ModuleSentiment mod in mods) {
      workload += mod.getWorkload();
    }
    return workload / mods.length;
  }

  static calculateDifficulty(List<ModuleSentiment> mods) {
    int diff = 0;
    for (ModuleSentiment mod in mods) {
      diff += mod.getDifficulty();
    }
    return diff / mods.length;
  }

  static calculateGPABySemester(String ays, List<Module> mods) {
    double credits = 0;
    double grades = 0;
    for (Module mod in mods) {
      if (mod.done && mod.ays == ays) {
        credits += mod.credits;
        grades += mod.grade;
      }
    }
    return grades / credits;
  }
}
