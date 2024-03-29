// import 'package:flutter/material.dart';
// import 'package:gradis/services/UserAPI.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/rendering.dart';

// class GoalCAPTextField extends StatefulWidget {
//   final String initialText;
//   final String id;
//   GoalCAPTextField({required this.initialText, required this.id});

//   @override
//   _GoalCAPTextFieldState createState() => _GoalCAPTextFieldState();
// }

// class _GoalCAPTextFieldState extends State<GoalCAPTextField> {
//   bool _isEditingText = false;
//   late TextEditingController _editingController;
//   late String text;

//   @override
//   void initState() {
//     super.initState();
//     text = widget.initialText;
//     _editingController = TextEditingController(text: widget.initialText);
//   }

//   @override
//   void dispose() {
//     _editingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50,
//       decoration: new BoxDecoration(
//         shape: BoxShape.rectangle,
//         border: new Border.all(
//           color: Colors.white,
//           width: 1.0,
//         ),
//       ),
//       child: TextField(
//         textAlign: TextAlign.center,
//         keyboardType:
//             TextInputType.numberWithOptions(signed: true, decimal: true),
//         onSubmitted: (newValue) {
//           print("new value: " + newValue);
//           Provider.of<UserAPI>(context, listen: false)
//               .updateGoalCAP(double.parse(newValue), widget.id);
//         },
//       ),
//     );
//   }
// }
