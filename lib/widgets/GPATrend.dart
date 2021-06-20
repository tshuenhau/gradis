import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'dart:math';

class GPATrend extends StatefulWidget {
  //TODO: Make the data here reactive to API call.
  @override
  _GPATrendState createState() => _GPATrendState();
}

class _GPATrendState extends State<GPATrend> {
  List<String> rawSemesters = [];
  List<String> semesters = [];

  List<double> discreteGPA = [];

  List<double> cummulativeGPA = [];

  List<FlSpot> discreteData = [];
  List<FlSpot> cummulativeData = [];

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  String type = "Discrete";

  @override
  void initState() {
    rawSemesters = [
      "2020 S1",
      "2020 S2",
      "2021 S1",
      "2022 S2",
      "2023 S1"
    ]; // TODO FILL THIS WITH API ZQ. JUST FILL WITH THE SEMESTERS THAT HAVE DONE MODULES. MAYBE SORT IT WILL B GUD

    for (int i = 0; i < rawSemesters.length; i++) {
      semesters.add(rawSemesters[i].substring(2, rawSemesters[i].length));
    }
    discreteGPA = [4.5, 4.29, 4.2, 4.3, 4.5]; // TODO FILL THIS WITH API ZQ
    cummulativeGPA = [4.5, 4.2, 4.1, 4.0, 3.7]; // TODO FILL THIS WITH API ZQ
    for (int i = 0; i < discreteGPA.length; i++) {
      discreteData.add(FlSpot(i.toDouble(), discreteGPA[i]));
      cummulativeData.add(FlSpot(i.toDouble(), cummulativeGPA[i]));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 8,
        //shadowColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Accent, width: 0.8),
            borderRadius: BorderRadius.circular(
              20,
            )),
        color: ModuleTileColor,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              child: AspectRatio(
                aspectRatio: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 35.0, left: 12.0, top: 24, bottom: 24),
                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140.0, top: 120),
              child: SizedBox(
                width: 100,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                      if (type == "Discrete") {
                        type = "Cummulative";
                        print(type);
                      } else {
                        type = "Discrete";
                      }
                    });
                  },
                  child: Text(
                    type,
                    style: TextStyle(
                        fontSize: 12,
                        color: showAvg
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        topTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return semesters[value.toInt()];
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            for (double i =
                    ((discreteGPA.reduce(min) * 2).round() / 2).toDouble();
                i <= ((discreteGPA.reduce(max) * 2).round() / 2).toDouble();
                i++) {
              if (value == i) {
                print("i" + i.toString());
                return i.toString();
              }
            }

            return "";
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: semesters.length.toDouble() - 1,
      minY: ((discreteGPA.reduce(min) * 2).round() / 2).toDouble(),
      maxY: ((discreteGPA.reduce(max) * 2).round() / 2).toDouble() + 0.1,
      lineBarsData: [
        LineChartBarData(
          spots: discreteData,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return semesters[value.toInt()];
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            for (double i =
                    ((cummulativeGPA.reduce(min) * 2).round() / 2).toDouble();
                i <= ((cummulativeGPA.reduce(max) * 2).round() / 2).toDouble();
                i++) {
              if (value == i) {
                print("i" + i.toString());
                return i.toString();
              }
            }

            return "";
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: semesters.length.toDouble() - 1,
      minY: ((cummulativeGPA.reduce(min) * 2).round() / 2).toDouble(),
      maxY: ((cummulativeGPA.reduce(max) * 2).round() / 2).toDouble() + 0.1,
      lineBarsData: [
        LineChartBarData(
          spots: cummulativeData,
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
