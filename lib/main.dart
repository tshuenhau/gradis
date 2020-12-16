import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:provider/provider.dart';
import 'package:gradis/screens/InputPage.dart';
import 'package:gradis/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: InputPage(),
    );
  }
}
