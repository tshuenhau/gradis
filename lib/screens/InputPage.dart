import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradis/services/UserAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradis/classes/GoalCAP.dart';
import 'package:gradis/screens/WelcomeScreen.dart';

const TextStyle capTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
const TextStyle titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 10.0,
  fontWeight: FontWeight.w400,
);

const Color IconsColor = Colors.white;

class InputPage extends StatefulWidget {
  static const String id = 'input_screen';
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();
    return Scaffold(
        backgroundColor: RaisinBlack,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('modules')
                      .where('user', isEqualTo: loggedInUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Consumer<UserAPI>(
                          builder: (context, modulesData, child) {
                        return Container(
                          color: Colors.black,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Total",
                                        textAlign: TextAlign.left,
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        Provider.of<UserAPI>(context,
                                                listen: false)
                                            .calculateTotalCAP()
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.left,
                                        style: capTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Current",
                                        textAlign: TextAlign.left,
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        Provider.of<UserAPI>(context,
                                                listen: false)
                                            .calculateCurrentCAP()
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.left,
                                        style: capTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: const Text(
                                    "Gradis",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Future",
                                        textAlign: TextAlign.left,
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        Provider.of<UserAPI>(context,
                                                listen: false)
                                            .calculateFutureCAP()
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.left,
                                        style: capTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Goal",
                                        textAlign: TextAlign.left,
                                        style: titleTextStyle,
                                      ),
                                      StreamBuilder<GoalCAP>(
                                          stream: Provider.of<UserAPI>(context,
                                                  listen: false)
                                              .findGoalCAP(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final goalCAP = snapshot.data;
                                              final id = goalCAP!.id;
                                              Provider.of<UserAPI>(context,
                                                      listen: false)
                                                  .setGoalCAP(goalCAP.goal);

                                              return GoalCAPTextField(
                                                  id: id,
                                                  initialText: goalCAP.goal
                                                      .toStringAsFixed(2));
                                            } else {
                                              return GoalCAPTextField(
                                                  id: 'first-creation',
                                                  initialText: '');
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      });
                    } else {
                      return Text("", style: const TextStyle());
                    }
                  }),
            ),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: Provider.of<UserAPI>(context, listen: false)
                    .findAllModules(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final modules = snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> document) {
                      final data = document;
                      return Module.fromFirestore(data);
                    }).toList();
                    print('modules');
                    print(modules);
                    Provider.of<UserAPI>(context, listen: false)
                        .setModules(modules);
                    return Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        color: RaisinBlack,
                      ),
                      child: GradesList(scrollController: scrollController),
                    );
                  } else {
                    print("WAT");
                    print(snapshot.hasData);
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: RaisinBlack,
                      ),
                      child: Text("Loading"),
                    );
                  }
                }),
          ),
        ]),
        bottomNavigationBar: CustomBottomAppBar(),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton(
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.add),
              onPressed: () {
                print(DateTime.now());
                final newMod = Module(
                    name: "new",
                    grade: 0,
                    credits: 0,
                    workload: 0,
                    difficulty: 0,
                    ays: {'year': 2020, 'semester': 1},
                    su: false,
                    done: false,
                    createdAt: DateTime.now());
                Provider.of<UserAPI>(context, listen: false)
                    .createModule(newMod);
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeOut);
                }
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Drawer(
            child: SafeArea(
              right: false,
              child: ListView(
                // will need to replace this with a listview builder to fill the "semesters according to user input/ stuff stored in dB"
                padding: EdgeInsets.zero,
                children: const <Widget>[
                  SizedBox(
                    height: 65,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: RaisinBlack,
                      ),
                      child: Text(
                        'Semester',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('All Semesters'),
                      tileColor: RaisinBlack,
                    ),
                  ),
                  ListTile(
                    title: Text('Year 1 Semester 1'),
                  ),
                  ListTile(
                    title: Text('Year 1 Semester 2'),
                  ),
                  ListTile(
                    title: Text('Year 2 Semester 1'),
                  ),
                  ListTile(
                    title: Text('Future Semesters'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomBottomAppBar extends StatelessWidget {
  // const CustomBottomAppBar({Key? key}): super(key: key);

  final _auth = FirebaseAuth.instance;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.black,
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip:
                  'Open navigation menu', // this opens up like the side appbar where u can select the semester
              icon: const Icon(Icons.menu),
              color: IconsColor,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {
                print(Provider.of<UserAPI>(context, listen: false).modules);
              },
              color: IconsColor,
            ),
            if (centerLocations
                .contains(FloatingActionButtonLocation.centerDocked))
              const Spacer(),
            IconButton(
              tooltip: 'Settings', // settings and goal
              icon: const Icon(Icons.settings),
              color: IconsColor,
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
