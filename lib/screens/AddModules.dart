import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/constants.dart';

class AddModulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newModuleName = "";
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
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () {
                final module = Module(
                  name: newModuleName,
                  grade: 4.5,
                  credits: 4,
                  workload: 0,
                  difficulty: 0,
                  ays: "2021 S1",
                  su: false,
                  done: false,
                );
                Provider.of<UserAPI>(context, listen: false)
                    .createModule(module);
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
