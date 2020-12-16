import 'package:flutter/material.dart';
import 'package:gradis/widgets/EditableTextField.dart';

class ModuleTile extends StatefulWidget {
  final String moduleName;
  final int credits;
  final double grade;

  ModuleTile(
    {this.moduleName,
    this.credits,
    this.grade}
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
      // ),
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,  
        children: [
          EditableTextField(widget.moduleName),
          EditableTextField(widget.credits.toString()),
          EditableTextField(widget.grade.toString()),
        ],
      ),
      // trailing: Text(
      //   grade.toString(),
      // ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),

      isThreeLine: false,
    );
  }
}