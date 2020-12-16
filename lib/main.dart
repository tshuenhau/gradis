import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'module.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int id = 0;
  String name;
  double grade;
  int credits;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Name',
        ),
        TextFormField(
          onSaved: (text) {
            name = text;
          },
        ),
        Text(
          'Grade',
        ),
        TextFormField(
          onSaved: (text) {
            grade = double.parse(text);
          },
        ),
        Text(
          'credits',
        ),
        TextFormField(
          onSaved: (text) {
            credits = int.parse(text);
          },
        ),
        FlatButton(
          child: Text('Insert Module'),
          onPressed: () {
            DBProvider.db.insertModule(
              Module(id: id, name: name, grade: grade, credits: credits),
            );
          },
        )
      ],
    );
  }
}
