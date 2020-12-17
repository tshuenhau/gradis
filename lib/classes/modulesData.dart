import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';
import 'calculator.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  //double currentCAP = 7; //TODO: dummy data
  //bool incCap = false; //TODO: dummy data
  double goal = 4.0; // this needs to be stored in DB somewhere
  
  static Calculator calculator = Calculator(goalCAP:0);

  //access database and get a list of modules

  void getModulesFromDB() async {
    dbModules = DBProvider.db.getAllModules();
    modules = await dbModules;
    dbModules.then((value) => 
      calculator = Calculator(goalCAP:goal)
    );    
  }

  void addModule(Module module) async {
    modules.add(module);
    await DBProvider.db.insertModule(module);
    notifyListeners();
  }

  void updateModule(Module newModule) async {
    for (int i = 0 ; i < modules.length; i++) {
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

  bool incCAP() {
    // checks if current CAP is less than goal CAP
    //print("goal CAP: " + calculator.goalCAP.toString());
    return calculator.increaseCAP(calculateCurrentCAP());
  }

  double calculateCurrentCAP() {
    double totalGrade = 0;
    int completedModsCounter = 0;
    for (Module mod in modules) {
        totalGrade += mod.grade;
        completedModsCounter += 1;
    }
    //print("totalGrade: " + totalGrade.toString());

    return totalGrade / completedModsCounter;
  }
}
