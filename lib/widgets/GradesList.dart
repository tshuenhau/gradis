import 'package:flutter/material.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:gradis/widgets/moduleTile.dart';
import 'package:provider/provider.dart';




class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ModulesData>(
        builder: (context, modulesData,child){
          return ListView.builder(
          shrinkWrap: true,
          itemCount: modulesData.modules.length,
          itemBuilder: (context, index) {
          return ModuleTile(
              moduleName: modulesData.modules[index].name, credits: modulesData.modules[index].credits, grade:modulesData.modules[index].grade
          ); // ModuleTile not yet created
        },
        );
      },
    );
  }
}
