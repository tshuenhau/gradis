import 'package:flutter/material.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:gradis/widgets/DifficultyChart.dart';
import 'package:gradis/widgets/WorkloadChart.dart';

import 'package:gradis/constants.dart';

Future<dynamic> buildAddModuleBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddModule(),
        );
      });
}

class AddModule extends StatefulWidget {
  const AddModule({
    Key? key,
  }) : super(key: key);

  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  String? _chosenSemester;

  @override
  Widget build(BuildContext context) {
    String newModuleName;
    List<String> semesters = [
      '2020 S1',
      '2020 S2',
      '2021 S1',
      '2021 S2',
      '2022 S1',
      '2022 S2'
    ];
    //return SimpleBarChart();
    return Container(
        height: MediaQuery.of(context).size.height * (7 / 12),
        padding: EdgeInsets.only(left: 45.0, right: 45, bottom: 45, top: 30),
        decoration: BoxDecoration(
          color: ModuleTileColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Add Module",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Highlight,
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                border: Border.all(
                    color: Accent, width: 1.0, style: BorderStyle.solid),
              ),
              child: Center(
                child: DropdownButton<String>(
                  underline: Container(),
                  menuMaxHeight: MediaQuery.of(context).size.height * (5 / 12),
                  value: _chosenSemester,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:
                      semesters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(
                          value,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a semester",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _chosenSemester = value;
                      print(value);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              autofocus: false,
              onChanged: (newText) {
                newModuleName = newText;
              },
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Module Name'),
            ),
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              autofocus: false,
              onChanged: (newText) {
                newModuleName = newText;
              },
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Module Credits'),
            ),
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              autofocus: false,
              onChanged: (newText) {
                newModuleName = newText;
              },
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Module Grade'),
            ),
            SizedBox(height: 25),
            Material(
              color: GreenHighlight,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () async {},
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Add Module',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ));
  }
}
