import 'package:flutter/material.dart';
//import 'package:gradis/classes/module.dart';
import 'package:gradis/classes/modulesData.dart';
import 'package:gradis/widgets/ModuleTile.dart';
import 'package:provider/provider.dart';

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
            print(modulesData.modules[index]);
            return ModuleTile(index); // ModuleTile not yet created
          },
        );
      },
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return FutureBuilder<List<Module>>(
//       future: modules,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Module> mods = snapshot.data;
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: mods.length,
//             itemBuilder: (context, index) {
//               return ModuleTile(
//                 moduleName: mods[index].name,
//                 credits: mods[index].credits,
//                 grade: mods[index].grade,
//               );
//             },
//           );
//         }
//         else {
//           return Container(
//             width: 10,
//             //TODO: TH you can design this container when there are no modules in DB if you want
//             child: Text('wat'),
//           );
//         }
//       });
// }
