import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
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
          }),
    );
  }
}
