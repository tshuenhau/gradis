import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';
import 'package:provider/provider.dart';
import 'package:gradis/services/GlobalSentimentAPI.dart';

// const Map<int, double> difficultyData = {
//   1: 0, //? 1hr : 0 votes
//   2: 6, //? 2hr : 6 votes
//   3: 7,
//   4: 5,
//   5: 6,
//   6: 6,
//   7: 10,
//   8: 11,
//   9: 12,
//   10: 12,
// };

class DifficultyChart extends StatefulWidget {
  DifficultyChart(this.difficultyMap);
  late Map<int, double> difficultyMap;
  @override
  State<StatefulWidget> createState() => DifficultyChartState();
}

class DifficultyChartState extends State<DifficultyChart> {
  late List<BarChartGroupData> barGroups;
  late double maxY = 0;

  void processData(Map data) {
    maxY = 0;
    List<BarChartGroupData> dataList = [];
    data.forEach((key, value) {
      dataList.add(BarChartGroupData(
        x: key,
        barRods: [
          BarChartRodData(
              y: value.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
      ));
      if (value > maxY) {
        maxY = value;
      }
    });
    maxY += 1;
    barGroups = [for (var items in dataList) items];
    print("MAXY " + maxY.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    processData(widget.difficultyMap);
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 7.0,
        color: ModuleTileColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 8.0, bottom: 14.0),
          child: Column(
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return '0';
                            case 1:
                              return '1';
                            case 2:
                              return '2';
                            case 3:
                              return '3';
                            case 4:
                              return '4';
                            case 5:
                              return '5';
                            case 6:
                              return '6';
                            case 7:
                              return '7';
                            case 8:
                              return '8';
                            case 9:
                              return '9';
                            case 10:
                              return '10';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: barGroups,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("Difficulty"),
            ],
          ),
        ),
      ),
    );
  }
}
