import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradis/database.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/constants.dart';



class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newModuleName;
    return Container(
      color: Color(0x00000000),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: DarkCharcoal,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Module',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: LightSilver,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newModuleName = newText;
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: RaisinBlack,
              onPressed: () async {
                await DBProvider.db.insertModule(Module(id: 0, name: newModuleName, grade: 4.5, credits: 4));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}