import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';

class CustomSiderNavBar extends StatelessWidget {
  const CustomSiderNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    color: BackgroundColor,
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
    );
  }
}
