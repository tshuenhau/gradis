import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:gradis/classes/GoalCAP.dart';

//TODO: EDITED HERE
class GoalCAPTextField extends StatefulWidget {
  final String initialText;
  GoalCAPTextField({@required this.initialText});

  @override
  _GoalCAPTextFieldState createState() => _GoalCAPTextFieldState();
}

class _GoalCAPTextFieldState extends State<GoalCAPTextField> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String text;

  @override
  void initState() {
    super.initState();
    text = widget.initialText;
    _editingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditingText) {
      return Container(
        width: 50,
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onSubmitted: (newValue) {
            print("new value: " + newValue);
            final newGoal = GoalCAP(goal: double.parse(newValue));
            Provider.of<ModulesData>(context, listen: false)
                .updateGoalCAP(newGoal);
            setState(() {
              text = Provider.of<ModulesData>(context, listen: false)
                  .goalCAP
                  .toStringAsFixed(2);
              _isEditingText = false;
            });
          },
        ),
      );
    }
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          text != null ? text : "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ));
  }
}
