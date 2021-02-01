import 'package:flutter/material.dart';
//import 'package:gradis/classes/module.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:provider/provider.dart';
import 'package:gradis/constants.dart';
import 'package:sticky_headers/sticky_headers.dart';

class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  //ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModulesData>(
      builder: (context, modulesData, child) {
        return ListView.builder(
          //controller: scrollController,
          shrinkWrap: true,
          itemCount: modulesData.modules.length,
          itemBuilder: (context, index) {
            //print(modulesData.modules[index]);
            return ModuleTile(index);
          },
        );
      },
    );
  }
}
