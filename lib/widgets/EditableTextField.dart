import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditableTextField extends StatefulWidget {
  final String initialText;
  EditableTextField(this.initialText);

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String text;

  @override
  void initState(){
    text = widget.initialText;
    super.initState();
    _editingController = TextEditingController(text: widget.initialText);
  }
  @override
  void dispose(){
    _editingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (_isEditingText)
      return Container(
        width: 60,
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              text = newValue;
              _isEditingText =false;
            });
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
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      )
    );
  }
}
