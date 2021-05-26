import 'package:flutter/material.dart';
import 'package:gradis/widgets/EditableTextField.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/classes/module.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      return Card(
        elevation: 5.0,
        color: ModuleTileColor,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: buildListTile(context),
          actions: <Widget>[
            IconSlideAction(
              caption: 'More',
              color: Onyx,
              icon: Icons.more_horiz,
              foregroundColor: Accent,
              onTap: () => ('More'), //TODO: ADD THE FEEDBACK PAGE/ MORE PAGE
            ),
            IconSlideAction(
                caption: "Delete",
                color: DarkCharcoal,
                foregroundColor: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  Provider.of<UserAPI>(context, listen: false)
                      .deleteModule(widget.module.getID().toString());
                })
          ],
        ),
      );
    });
  }

  ListTile buildListTile(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          checkColor: Colors.black, // color of tick Mark
          activeColor: Highlight,
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
                  su: widget.module.su);
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
                    initialText: UserAPI.modules[widget.index].name,
                    module: UserAPI.modules[widget.index],
                    type: "name")),
            Expanded(
              child: EditableTextField(
                  initialText: UserAPI.modules[widget.index].credits.toString(),
                  module: UserAPI.modules[widget.index],
                  type: "credits"),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EditableTextField(
                    initialText: UserAPI.modules[widget.index].grade.toString(),
                    module: UserAPI.modules[widget.index],
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
  }
}
