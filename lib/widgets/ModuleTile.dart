import 'package:flutter/material.dart';
import 'package:gradis/classes/calculator.dart';
import 'package:gradis/widgets/EditableTextField.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:provider/provider.dart';

import '../classes/modulesData.dart';
import '../classes/modulesData.dart';
import '../classes/modulesData.dart';
import '../classes/modulesData.dart';

class ModuleTile extends StatefulWidget {
  final int index;
  ModuleTile(this.index);
  @override
  _ModuleTileState createState() => _ModuleTileState();
}

class _ModuleTileState extends State<ModuleTile> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModulesData>(builder: (context, modulesData, child){
      checkedValue = modulesData.modules[widget.index].isDone();
        return ListTile(
          leading: Checkbox(
            value: checkedValue, 
            onChanged: (newText) {
                    setState(() {
                      checkedValue = !checkedValue;
                      modulesData.toggleDone(widget.index);
                //       Provider.of<ModulesData>(context, listen: false)
                // .updateModule(newModule);
                    });
                  }
            ),
          title: Consumer<ModulesData>(builder: (context, modulesData, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //TODO: these stuff be long maybe find a way to shorten it so it dont look so cancer
                Expanded(
                    child: EditableTextField(
                        initialText: modulesData.modules[widget.index].name,
                        module: modulesData.modules[widget.index],
                        type: "name")),
                Expanded(
                  child: EditableTextField(
                      initialText:
                          modulesData.modules[widget.index].credits.toString(),
                      module: modulesData.modules[widget.index],
                      type: "credits"),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EditableTextField(
                        initialText:
                            modulesData.modules[widget.index].grade.toString(),
                        module: modulesData.modules[widget.index],
                        type: "grade"),
                  ],
                ))
              ],
            );
          }),
          trailing: Icon(
              Provider.of<ModulesData>(context, listen: false).incCAP() == 1
                  ? Icons.arrow_drop_up
                  : Provider.of<ModulesData>(context, listen: false).incCAP() == -1
                      ? Icons.arrow_drop_down
                      : null, //TODO: you can add an icon if u want
              color: Provider.of<ModulesData>(context, listen: false).incCAP() == 1
                  ? Colors.red
                  : Provider.of<ModulesData>(context, listen: false).incCAP() == -1
                      ? Colors.green
                      : Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),

          isThreeLine: false,
      );
    });
  }
}
