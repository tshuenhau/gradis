import 'package:flutter/material.dart';

class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  List<Module> module = [ // Module Class not yet finished
    Module("CS1231", 4, 4.5),
    Module("IS1103", 4, 1.5),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ModuleTile(moduleName: module[index]); // ModuleTile not yet created
      }
    );
    
  }
}