import 'package:flutter/material.dart';
import 'package:gradis/widgets/EditableTextField.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/classes/module.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gradis/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gradis/screens/ModuleSentiment.dart';

class ModuleTile extends StatefulWidget {
  final int index;
  final Module module;
  // ModuleTile(required this.index, required this.module);
  ModuleTile({
    Key? key,
    required this.index,
    required this.module,
  }) : super(key: key);

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
              onTap: () => (buildModuleSentimentBottomSheet(
                  context, widget)), //TODO: ADD THE FEEDBACK PAGE/ MORE PAGE
            ),
            IconSlideAction(
                caption: "Delete",
                color: DarkCharcoal,
                foregroundColor: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  Provider.of<UserAPI>(context, listen: false)
                      .deleteModule(widget.module);
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
                  su: widget.module.su,
                  createdAt: widget.module.createdAt);
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      isThreeLine: false,
    );
  }
}
