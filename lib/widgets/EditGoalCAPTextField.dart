import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class GoalCAPTextField extends StatefulWidget {
  final String initialText;
  final String id;
  GoalCAPTextField({required this.initialText, required this.id});

  @override
  _GoalCAPTextFieldState createState() => _GoalCAPTextFieldState();
}

class _GoalCAPTextFieldState extends State<GoalCAPTextField> {
  bool _isEditingText = false;
  late TextEditingController _editingController;
  late String text;

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
            if (widget.id == 'first-creation') {
              Provider.of<UserAPI>(context, listen: false)
                  .createGoalCAP(double.parse(newValue));
            } else {
              Provider.of<UserAPI>(context, listen: false)
                  .updateGoalCAP(double.parse(newValue), widget.id);
            }
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
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ));
  }
}
