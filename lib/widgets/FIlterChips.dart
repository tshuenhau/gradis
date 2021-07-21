import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';

typedef StringValue = void Function(String);

class FilterChips extends StatefulWidget {
  @override
  _FilterChipsState createState() => _FilterChipsState();
  late final StringValue callback;
  FilterChips(StringValue callback) {
    this.callback = callback;
  }
}

class _FilterChipsState extends State<FilterChips> {
  int? _selectedIndex = 0;
  String?
      _selectedSemester; //TODO: THIS NEEDS TO BE PASSED INTO GRADESLIST SO THAT IT CAN FILTER OR ITS PASSED INTO API OR SMTH

  List<Widget> chips = [];
  List<String> _options = [
    'All',
    '2020 S1',
    '2020 S2',
    '2021 S1',
    '2021 S2',
    '2022 S1',
    '2022 S2',
    '2023 S1',
    '2023 S2'
  ];
  Map<int, String> _hMap = {
    0: 'All', //TODO THIS FILTER DOES NOT WORK.
    1: '2020 S1',
    2: '2020 S2',
    3: '2021 S1',
    4: '2021 S2',
    5: '2022 S1',
    6: '2022 S2',
    7: '2023 S1',
    8: '2023 S2'
  };

  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i], style: TextStyle(color: Colors.white)),
        //avatar: FlutterLogo(),
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 1)),

        elevation: 3,
        pressElevation: 5,
        // shadowColor: Highlight,
        backgroundColor: ModuleTileColor,

        selectedColor: DarkLiver,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              _selectedSemester = _hMap[i];
              widget.callback(_selectedSemester!);
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 45, child: _buildChips());
  }
}
