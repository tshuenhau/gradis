import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'dart:math';
import 'package:gradis/services/UserAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:gradis/classes/module.dart';

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

  // @override
  // void initState() {
  //   rawSemesters = [
  //     "2020 S1",
  //     "2020 S2",
  //     "2021 S1",
  //     "2022 S2",
  //     "2023 S1"
  //   ]; // TODO FILL THIS WITH API ZQ. JUST FILL WITH THE SEMESTERS THAT HAVE DONE MODULES. MAYBE SORT IT WILL B GUD

  //   for (int i = 0; i < rawSemesters.length; i++) {
  //     semesters.add(rawSemesters[i].substring(2, rawSemesters[i].length));
  //   }
  //   discreteGPA = [4.5, 4.29, 4.2, 4.3, 4.5]; // TODO FILL THIS WITH API ZQ
  //   cummulativeGPA = [4.5, 4.2, 4.1, 4.0, 3.7]; // TODO FILL THIS WITH API ZQ
  //   for (int i = 0; i < discreteGPA.length; i++) {
  //     discreteData.add(FlSpot(i.toDouble(), discreteGPA[i]));
  //     cummulativeData.add(FlSpot(i.toDouble(), cummulativeGPA[i]));
  //   }

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: Provider.of<UserAPI>(context, listen: false).findAllModules(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final modules = snapshot.data!.docs
                .map((DocumentSnapshot<Map<String, dynamic>> document) {
              final data = document;
              return Module.fromFirestore(data);
            }).toList();
            Provider.of<UserAPI>(context, listen: false).setAllModules(modules);
          }
          Provider.of<UserAPI>(context, listen: false).setAllDoneModules();
          this.rawSemesters =
              Provider.of<UserAPI>(context, listen: false).getAllDoneAys();
          semesters = [];
          for (int i = 0; i < rawSemesters.length; i++) {
            semesters.add(rawSemesters[i].substring(2, rawSemesters[i].length));
          }
          this.discreteGPA = Provider.of<UserAPI>(context, listen: false)
              .calculateDiscreteGPA(this.rawSemesters);
          this.cummulativeGPA = Provider.of<UserAPI>(context, listen: false)
              .calculateCumulativeGPA(this.rawSemesters);
          discreteData = [];
          cummulativeData = [];
          for (int i = 0; i < discreteGPA.length; i++) {
            discreteData.add(FlSpot(i.toDouble(), discreteGPA[i]));
            cummulativeData.add(FlSpot(i.toDouble(), cummulativeGPA[i]));
          }
          print("all ays " +
              Provider.of<UserAPI>(context, listen: false)
                  .getAllDoneAys()
                  .toString());
          print("discrete GPA " + this.discreteGPA.toString());
          print("cumulative GPA " + this.cummulativeGPA.toString());

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
                      height: 155,
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 35.0, left: 35.0, top: 24, bottom: 24),
                          child: LineChart(
                            showAvg ? avgData() : mainData(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 140.0, top: 140, bottom: 6),
                      child: SizedBox(
                        width: 100,
                        height: 30,
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
                )),
          );
        });
  }

  LineChartData mainData() {
    List<int> showIndexes = [
      for (var i = 0; i < semesters.length; i += 1) i
    ]; //! This needs to be DYNAMIC

    var lineBarsDataDiscrete = [
      LineChartBarData(
        spots: discreteData, //! This needs to be DYNAMIC
        showingIndicators: showIndexes, //! This needs to be DYNAMIC
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
    ];
    return LineChartData(
      showingTooltipIndicators: showIndexes.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
              lineBarsDataDiscrete[0],
              lineBarsDataDiscrete.indexOf(lineBarsDataDiscrete[0]),
              lineBarsDataDiscrete[0].spots[index])
        ]);
      }).toList(),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
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
              fontSize: 14),
          getTitles: (value) {
            return semesters[value.toInt()];
          },
          margin: 30,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            return "";
          },
          reservedSize: 12,
          margin: 12,
        ),
      ),
      lineTouchData: LineTouchData(
        enabled: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.transparent,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.transparent,
                  strokeWidth: 0.5,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 8,
          tooltipMargin: 1,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toStringAsFixed(2),
                const TextStyle(
                    color: LightSilver, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: semesters.length.toDouble() - 1,
      minY: discreteGPA.length != 0
          ? ((discreteGPA.reduce(min) * 2).round() / 2).toDouble() - 0.5
          : 0.0,
      maxY: discreteGPA.length != 0
          ? ((discreteGPA.reduce(max) * 2).round() / 2).toDouble() + 0.5
          : 5.0,
      lineBarsData: lineBarsDataDiscrete,
    );
  }

  LineChartData avgData() {
    List<int> showIndexes = [for (var i = 0; i < semesters.length; i += 1) i];

    var lineBarsDataCummulative = [
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
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 3,
            color: Colors.transparent,
            strokeWidth: 0.5,
            strokeColor: Colors.white,
          ),
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
    ];
    return LineChartData(
      showingTooltipIndicators: showIndexes.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
              lineBarsDataCummulative[0],
              lineBarsDataCummulative.indexOf(lineBarsDataCummulative[0]),
              lineBarsDataCummulative[0].spots[index])
        ]);
      }).toList(),
      lineTouchData: LineTouchData(
        enabled: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.transparent,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.transparent,
                  strokeWidth: 0.5,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 8,
          tooltipMargin: 1,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toStringAsFixed(2),
                const TextStyle(
                    color: LightSilver, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      ),
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
          reservedSize: 15,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          getTitles: (value) {
            return semesters[value.toInt()];
          },
          margin: 30,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return "";
          },
          reservedSize: 12,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: semesters.length.toDouble() - 1,
      minY: cummulativeGPA.length != 0
          ? ((cummulativeGPA.reduce(min) * 2).floor() / 2).toDouble() - 0.5
          : 0.0,
      maxY: cummulativeGPA.length != 0
          ? ((cummulativeGPA.reduce(max) * 2).round() / 2).toDouble() + 0.5
          : 5.0,
      lineBarsData: lineBarsDataCummulative,
    );
  }
}
