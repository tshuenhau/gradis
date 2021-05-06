import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:gradis/widgets/GradesList.dart';
import 'package:gradis/classes/ModulesData.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';
import 'package:gradis/widgets/EditGoalCAPTextField.dart';

const TextStyle capTextStyle = TextStyle(
  color: LightSilver,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
const TextStyle titleTextStyle = TextStyle(
  color: LightSilver,
  fontSize: 10.0,
  fontWeight: FontWeight.w400,
);

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    Provider.of<ModulesData>(context, listen: false).getModules();
    Provider.of<ModulesData>(context, listen: false).getGoalCAP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Onyx,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: FutureBuilder<List<Module>>(
                  future: Provider.of<ModulesData>(context).dbModules,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Consumer<ModulesData>(
                          builder: (context, modulesData, child) {
                        Provider.of<ModulesData>(context, listen: false)
                            .calculateCurrentCAP();
                        return Container(
                          color: RaisinBlack,
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
                                        Provider.of<ModulesData>(context,
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
                                        Provider.of<ModulesData>(context,
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
                                      color: LightSilver,
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
                                        Provider.of<ModulesData>(context,
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
                                      GoalCAPTextField(
                                          initialText: Provider.of<ModulesData>(
                                                  context,
                                                  listen: false)
                                              .goalCAP
                                              .toStringAsFixed(2))
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      });
                    } else {
                      return Text("");
                    }
                  }),
            ),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Module>>(
                future: Provider.of<ModulesData>(context).dbModules,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        color: Onyx,
                      ),
                      child: GradesList(),
                    );
                  } else
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Onyx,
                      ),
                      child: Text("Loading"),
                    );
                }),
          ),
        ]),
        bottomNavigationBar: CustomBottomAppBar(),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton(
              backgroundColor: LightSilver,
              child: Icon(Icons.add),
              onPressed: () {
                final module = Module(id: 0, name: "new", grade: 0, credits: 0);
                Provider.of<ModulesData>(context, listen: false)
                    .addModule(module);
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
  const CustomBottomAppBar({
    Key key,
  }) : super(key: key);
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: RaisinBlack,
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip:
                  'Open navigation menu', // this opens up like the side appbar where u can select the semester
              icon: const Icon(Icons.menu),
              color: LightSilver,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              color: LightSilver,
              onPressed: () {},
            ),
            if (centerLocations
                .contains(FloatingActionButtonLocation.centerDocked))
              const Spacer(),
            IconButton(
              tooltip: 'Settings', // settings and goal
              icon: const Icon(Icons.settings),
              color: LightSilver,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
