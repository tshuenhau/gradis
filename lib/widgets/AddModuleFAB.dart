import 'package:flutter/material.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/classes/module.dart';
import 'package:provider/provider.dart';
import 'package:gradis/screens/AddModuleBottomSheet.dart';

class AddModuleFAB extends StatelessWidget {
  const AddModuleFAB({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: FloatingActionButton(
          backgroundColor: Highlight,
          child: Icon(Icons.add),
          onPressed: () {
            buildAddModuleBottomSheet(context);
            // final newMod = Module(
            //     name: "new",
            //     grade: 0,
            //     credits: 0,
            //     workload: 0,
            //     difficulty: 0,
            //     ays: {'year': 2020, 'semester': 1},
            //     su: false,
            //     done: false);
            // Provider.of<UserAPI>(context, listen: false).createModule(newMod);
            // if (scrollController.hasClients) {
            //   scrollController.animateTo(
            //       scrollController.position.maxScrollExtent,
            //       duration: Duration(microseconds: 300),
            //       curve: Curves.easeOut);
            // }
          }),
    );
  }
}
