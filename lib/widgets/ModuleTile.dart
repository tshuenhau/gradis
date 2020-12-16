import 'package:flutter/material.dart';
import 'package:gradis/widgets/EditableTextField.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';

class ModuleTile extends StatefulWidget {
  final int index;
  ModuleTile(
    this.index
  );
  @override
  _ModuleTileState createState() => _ModuleTileState();
}

class _ModuleTileState extends State<ModuleTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Text(
      //   moduleName,
      title:Consumer<ModulesData>(
          builder:(context, modulesData,child){
            return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  
            children: [
              //TODO: these stuff be long maybe find a way to shorten it so it dont look so cancer
              EditableTextField(initialText: modulesData.modules[widget.index].name, module:modulesData.modules[widget.index], type: "name"),
              EditableTextField(initialText: modulesData.modules[widget.index].credits.toString(), module:modulesData.modules[widget.index], type: "credits"),
              EditableTextField(initialText: modulesData.modules[widget.index].grade.toString(), module: modulesData.modules[widget.index], type: "grade"),
            ],
            );
          } 
      ),
      // trailing: Text(
      //   grade.toString(),
      // ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),

      isThreeLine: false,
    );
  }
}