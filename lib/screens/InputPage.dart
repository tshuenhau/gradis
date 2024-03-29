import 'package:flutter/material.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/widgets/CustomBottomAppBar.dart';
import 'package:gradis/widgets/CustomTopAppBar.dart';
import 'package:gradis/widgets/CustomSideNavBar.dart';
import 'package:gradis/widgets/AddModuleFAB.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/UserAPI.dart';

class InputPage extends StatefulWidget {
  static const String id = 'input_screen';
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _auth = FirebaseAuth.instance;
  late final User loggedInUser;

  void getCurrentUser() async {
    // to delete
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("LOGGED IN");
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserAPI>(context, listen: false).setSchool();
    print("WATWATWAT");
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();
    return Scaffold(
      appBar: CustomTopAppBar(context: context, loggedInUser: loggedInUser),
      body: GradesList(scrollController: scrollController),
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButton: AddModuleFAB(scrollController: scrollController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //drawer: CustomSiderNavBar()
    );
  }
}
