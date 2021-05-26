import 'package:flutter/material.dart';
import 'package:gradis/widgets/EditableTextField.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/constants.dart';

class ModuleTile extends StatefulWidget {
  final int index;
  final Module module;
  ModuleTile(this.index, this.module);
  @override
  _ModuleTileState createState() => _ModuleTileState();
}

class _ModuleTileState extends State<ModuleTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserAPI>(builder: (context, modulesData, child) {
      return ListTile(
        leading: Checkbox(
            checkColor: Colors.white, // color of tick Mark
            activeColor: GreenHighlight,
            value: widget.module.done,
            onChanged: (newText) {
              setState(() {
                Module updatedMod = new Module(
                    id: widget.module.id,
                    ays: widget.module.ays,
                    credits: widget.module.credits,
                    difficulty: widget.module.difficulty,
                    workload: widget.module.workload,
                    grade: widget.module.grade,
                    done: !widget.module.done,
                    name: widget.module.name,
                    su: widget.module.su,
                    timestamp: widget.module.timestamp);
                Provider.of<UserAPI>(context, listen: false)
                    .updateModule(updatedMod, widget.module.id);
              });
            }),
        title: Consumer<UserAPI>(builder: (context, modulesData, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TODO: these stuff be long maybe find a way to shorten it so it dont look so cancer
              Expanded(
                  child: EditableTextField(
                      initialText: Provider.of<UserAPI>(context, listen: false)
                          .modules[widget.index]
                          .name,
                      module: Provider.of<UserAPI>(context, listen: false)
                          .modules[widget.index],
                      type: "name")),
              Expanded(
                child: EditableTextField(
                    initialText: Provider.of<UserAPI>(context, listen: false)
                        .modules[widget.index]
                        .credits
                        .toString(),
                    module: Provider.of<UserAPI>(context, listen: false)
                        .modules[widget.index],
                    type: "credits"),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EditableTextField(
                      initialText: Provider.of<UserAPI>(context, listen: false)
                          .modules[widget.index]
                          .grade
                          .toString(),
                      module: Provider.of<UserAPI>(context, listen: false)
                          .modules[widget.index],
                      type: "grade"),
                ],
              ))
            ],
          );
        }),
        // trailing: Icon(
        //     Provider.of<UserAPI>(context, listen: false).incCAP() == 1
        //         ? Icons.arrow_drop_up
        //         : Provider.of<UserAPI>(context, listen: false).incCAP() == -1
        //             ? Icons.arrow_drop_down
        //             : null, //TODO: you can add an icon if u want
        //     color: Provider.of<UserAPI>(context, listen: false).incCAP() == 1
        //         ? Colors.red
        //         : Provider.of<UserAPI>(context, listen: false).incCAP() == -1
        //             ? Colors.green
        //             : Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        isThreeLine: false,
      );
    });
  }
}
