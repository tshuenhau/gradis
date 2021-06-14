import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/classes/module.dart';
import 'package:provider/provider.dart';

Future<dynamic> buildAddModuleBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate,
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
  String _newModuleName = "";
  int _newModuleCredits = 4;
  double _newModuleGrade = 5;
  @override
  Widget build(BuildContext context) {
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
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              autofocus: false,
              onChanged: (newText) {
                _newModuleName = newText;
                print(_newModuleName);
              },
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Module Name'),
            ),
            SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autofocus: false,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              onChanged: (value) {
                _newModuleCredits = int.parse(value);
                print(_newModuleCredits);

                print(_newModuleName);
              },
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Module Credits'),
            ),
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autofocus: false,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              onChanged: (value) {
                _newModuleGrade = double.parse(value);
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
                onPressed: () {
                  final newMod = Module(
                      name: _newModuleName,
                      grade: _newModuleGrade,
                      credits: _newModuleCredits,
                      workload: 0,
                      difficulty: 0,
                      ays: _chosenSemester!,
                      su: false,
                      done: false);
                  Provider.of<UserAPI>(context, listen: false)
                      .createModule(newMod);
                  // if (scrollController.hasClients) {
                  //   scrollController.animateTo(
                  //       scrollController.position.maxScrollExtent,
                  //       duration: Duration(microseconds: 300),
                  //       curve: Curves.easeOut);
                  // }
                  Navigator.pop(context);
                },
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
