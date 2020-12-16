import 'package:flutter/material.dart';
import 'package:gradis/module.dart';

class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  List<Module> module = [
    // Module Class not yet finished
    Module(id: 0, name: "CS1231", grade: 4.5, credits: 4),
    Module(id: 0, name: "IS1103", grade: 1.5, credits: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return ModuleTile(
          moduleName: module[index]); // ModuleTile not yet created
    });
  }
}
