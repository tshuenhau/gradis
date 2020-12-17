import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';
import 'calculator.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  Calculator calculator = Calculator(goalCAP: 4);
  double currentCAP;
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

  // bool incCAP() {
  //  // checks if current CAP is less than goal CAP
  //   return calculator.increaseCAP(currentCAP);
  // }
}
