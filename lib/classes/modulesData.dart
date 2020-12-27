import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';
import 'calculator.dart';
import 'goalcap.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  //double currentCAP = 7; //TODO: dummy data
  //bool incCap = false; //TODO: dummy data
  double goal = 4.0; // this needs to be stored in DB somewhere

  static Calculator calculator = Calculator(goalCAP: 0);

  //access database and get a list of modules

  void getGoalCAPFromDB() async {
    GoalCAP goalCAP = await DBProvider.db.getGoalCAP();
    goal = goalCAP.goal;
  }

  void getModulesFromDB() async {
    dbModules = DBProvider.db.getAllModules();
    modules = await dbModules;
    dbModules.then((value) => calculator = Calculator(goalCAP: goal));
  }

  void addModule(Module module) async {
    modules.add(module);
    await DBProvider.db.insertModule(module);
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

  // void calculateCAP() {
  //   currentCAP = calculator.cap(this.modules);
  // }

  int incCAP() {
    // checks if current CAP is less than goal CAP
    //print("goal CAP: " + calculator.goalCAP.toString());
    //print(calculator.increaseCAP(calculator.totalCAP(modules)));
    return calculator.increaseCAP(calculator.totalCAP(modules));
  }

  double calculateCurrentCAP() {
    //print("current CAP: " + calculator.currentCAP(modules).toString());
    return calculator.currentCAP(modules);
  }

  double calculateTotalCAP() {
    //print("current CAP: " + calculator.totalCAP(modules).toString());
    return calculator.totalCAP(modules);
  }

  double calculateFutureCAP() {
    //print("current CAP: " + calculator.totalCAP(modules).toString());
    return calculator.futureCAP(modules);
  }

  void toggleDone(int index) async {
    Module newModule = modules[index].toggleDone();
    print("oldModule: " + modules[index].toString());
    print("newModule: " + newModule.toString());

    for (int i = 0; i < modules.length; i++) {
      if (modules[i].id == newModule.id) {
        // can use id for this maybe later
        modules[i] = newModule;
      }
    }
    await DBProvider.db.updateModule(newModule);
    notifyListeners();
    print("isdone?" + modules[index].isDone().toString());
  }
}
