import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';
import 'calculator.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  Calculator calculator = Calculator(
      goalCAP:
          4.0); //TODO: dummy values, need to find way to integrate it into UI
  double currentCAP = 7; //TODO: dummy data
  bool incCap = false; //TODO: dummy data
  //access database and get a list of modules

  void getModulesFromDB() async {
    dbModules = DBProvider.db.getAllModules();
    modules = await dbModules;
  }

  void addModule(Module module) async {
    modules.add(module);
    await DBProvider.db.insertModule(module);
    notifyListeners();
  }

  void updateModule(Module newModule) async {
    for (Module module in modules) {
      if (module.id == newModule.id) {
        // can use id for this maybe later
        module = newModule;
      }
    }
    await DBProvider.db.updateModule(newModule);
    notifyListeners();
  }

  // void calculateCAP() {
  //   currentCAP = calculator.cap(this.modules);
  // } //TODO: Currently have error because Calculator class is using TestModule class

  void incCAP() {
    // checks if current CAP is less than goal CAP
    print("goal CAP: " + calculator.goalCAP.toString());
    incCap = this.calculator.increaseCAP(currentCAP);
    notifyListeners();
  }
}
