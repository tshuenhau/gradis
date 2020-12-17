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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Text(
      //   moduleName,
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
          Provider.of<ModulesData>(context, listen: false).incCap
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down,
          color: Provider.of<ModulesData>(context, listen: false).incCap
              ? Colors.red
              : Colors.green),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),

      isThreeLine: false,
    );
  }
}
