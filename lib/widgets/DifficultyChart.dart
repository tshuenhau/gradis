import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';

class DifficultyChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DifficultyChartState();
}

class DifficultyChartState extends State<DifficultyChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 7.0,
        color: ModuleTileColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
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
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(y: 7, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(y: 10, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(y: 11, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: 14, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(y: 16, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(y: 17, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(y: 16, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 7,
                        barRods: [
                          BarChartRodData(y: 14, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 8,
                        barRods: [
                          BarChartRodData(y: 11, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 9,
                        barRods: [
                          BarChartRodData(y: 8, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                      BarChartGroupData(
                        x: 10,
                        barRods: [
                          BarChartRodData(y: 6, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                      ),
                    ],
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
