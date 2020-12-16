import 'package:flutter/foundation.dart';
import 'package:gradis/classes/module.dart';


class ModulesData extends ChangeNotifier{
  //access database and get a list of modules
  List<Module> modules = [
    Module(id: 0, name: "CS1231", grade: 4.5, credits: 4),
    Module(id: 0, name: "IS1103", grade: 1.5, credits: 4),
  ];
}