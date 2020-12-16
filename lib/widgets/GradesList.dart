import 'package:flutter/material.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:gradis/database.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:provider/provider.dart';

class GradesList extends StatefulWidget {
  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  Future<List<Module>> modules = DBProvider.db.getAllModules();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Module>>(builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Module> mods = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: mods.length,
          itemBuilder: (context, index) {
            return ModuleTile(
              moduleName: mods[index].name,
              credits: mods[index].credits,
              grade: mods[index].grade,
            );
          },
        );
      } else {
        return Container(
            //TODO: TH you can design this container when there are no modules in DB if you want
            );
      }
    });
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ModulesData>(
//         builder: (context, modulesData,child){
//           return ListView.builder(
//           shrinkWrap: true,
//           itemCount: modulesData.modules.length,
//           itemBuilder: (context, index) {
//           return ModuleTile(
//               moduleName: modulesData.modules[index].name, credits: modulesData.modules[index].credits, grade:modulesData.modules[index].grade
//           ); // ModuleTile not yet created
//         },
//         );
//       },
//     );
//   }
// }
