import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';
import 'Calculator.dart';
import 'GoalCAP.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  double goalCAP;
  static Calculator calculator;

  //access database and get a list of modules

  void getModules() async {
    dbModules = DBProvider.db.getAllModules();
    modules = await dbModules;
    dbModules.then((value) => calculator = Calculator(goalCAP: this.goalCAP));
  }

  void addModule(Module module) async {
    modules.add(module);
    await DBProvider.db.addModule(module);
    notifyListeners();
  }

  void updateModule(Module newModule) async {
    for (int i = 0; i < modules.length; i++) {
      if (modules[i].id == newModule.id) {
        // can use id for this maybe later
        modules[i] = newModule;
      }
    }
    await DBProvider.db.updateModule(newModule);
    notifyListeners();
  }

  int incCAP() {
    // checks if current CAP is less than goal CAP
    return calculator.increaseCAP(calculator.totalCAP(modules));
  }

  double calculateCurrentCAP() {
    //print("current CAP: " + calculator.currentCAP(modules).toString());
    return calculator.currentCAP(modules);
  }

  double calculateTotalCAP() {
    //print("total CAP: " + calculator.totalCAP(modules).toString());
    double totalCAP = calculator.totalCAP(modules);
    return totalCAP == null ? 0.0 : totalCAP;
  }

  double calculateFutureCAP() {
    //print("current CAP: " + calculator.totalCAP(modules).toString());
    return calculator.futureCAP(modules);
  }

  void toggleDone(int index) async {
    Module newModule = modules[index].toggleDone();
    // print("oldModule: " + modules[index].toString());
    // print("newModule: " + newModule.toString());

    for (int i = 0; i < modules.length; i++) {
      if (modules[i].id == newModule.id) {
        // can use id for this maybe later
        modules[i] = newModule;
      }
    }
    await DBProvider.db.updateModule(newModule);
    notifyListeners();
    // print("isdone? " + modules[index].isDone().toString());
  }

  //TODO: EDITED HERE
  void getGoalCAP() async {
    GoalCAP goalCAP = await DBProvider.db.getGoalCAP();
    print("goal cap " + goalCAP.getGoalCap().toString());
    this.goalCAP = goalCAP.getGoalCap() == null ? 0.0 : goalCAP.getGoalCap();
    dbModules.then((value) => calculator = Calculator(goalCAP: this.goalCAP));
    notifyListeners();
  }

  void addGoalCAP(GoalCAP goalCAP) async {
    print('add goal CAP');
    await DBProvider.db.addGoalCAP(goalCAP);
    dbModules.then((value) => calculator = Calculator(goalCAP: this.goalCAP));
    notifyListeners();
  }

  void updateGoalCAP(GoalCAP goalCAP) async {
    print('update goal CAP');
    await DBProvider.db.updateGoalCAP(goalCAP);
    this.goalCAP = goalCAP.getGoalCap();
    print(this.goalCAP);
    dbModules.then(
        (value) => calculator = Calculator(goalCAP: goalCAP.getGoalCap()));
    notifyListeners();
  }
}
