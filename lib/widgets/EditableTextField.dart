import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';


class EditableTextField extends StatefulWidget { // constructor takes in the text, the module, and its type: Module/Credits/Grade
  final String initialText;
  final Module module;
  final String type;
  EditableTextField({this.initialText, this.module, this.type});

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String text;

  @override
  void initState() {
    text = widget.initialText;
    super.initState();
    _editingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditingText)
      return Container(
        width: 60,
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: widget.type == "name"? TextInputType.text: TextInputType.number,
          onSubmitted: (newValue) {
            setState(() {
              text = newValue;
              _isEditingText = false;
            });

            //the widget.module.XXX is just the original module data
              final String name = widget.type == "name" ? text: widget.module.name;
              final int credits = widget.type == "credits" ? int.parse(text) : widget.module.credits;
              print(credits);
              final double grade = widget.type == "grade" ? double.parse(text) : widget.module.grade;
              final Module newModule= Module(id: widget.module.id, name: name, credits: credits, grade: grade);
              Provider.of<ModulesData>(context, listen: false).updateModule(newModule);
              //TODO: bruh here is where i do the updateModule. p janky but it work.
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ));
  }
}
