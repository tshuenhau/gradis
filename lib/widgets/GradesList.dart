import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';

TextAlign alignment = TextAlign.center;

class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  //ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserAPI>(
      builder: (context, modules, child) {
        return ListView.builder(
          //controller: scrollController,
          shrinkWrap: true,
          itemCount: UserAPI.modules.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(children: <Widget>[
                Container(
                  height: 35,
                  child: ListTile(
                    tileColor: Onyx,
                    leading: Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 7.0),
                      child: Text(
                        'Done',
                        textAlign: alignment,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    title: Consumer<UserAPI>(
                        builder: (context, modulesData, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Module',
                              textAlign: alignment,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Credits',
                              textAlign: alignment,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Grade',
                              textAlign: alignment,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    trailing: Icon(Icons.arrow_drop_up, color: Colors.green),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    isThreeLine: false,
                  ),
                ),
                Divider(height: 10, thickness: 1),
              ]);
            }
            print(UserAPI.modules);
            return ModuleTile(index, UserAPI.modules[index]);
          },
        );
      },
    );
  }
}
