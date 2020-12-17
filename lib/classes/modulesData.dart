import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/database.dart';

class ModulesData extends ChangeNotifier {
  List<Module> modules;
  Future<List<Module>> dbModules;
  //access database and get a list of modules
  //List<Module> modules = [
  // Module(id: 0, name: "CS1231", grade: 4.5, credits: 4),
  // Module(id: 0, name: "IS1103", grade: 1.5, credits: 4),
  //];

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
}
