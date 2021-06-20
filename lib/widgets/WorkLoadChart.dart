import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradis/constants.dart';

class WorkloadChart extends StatefulWidget {
  WorkloadChart(this.workloadMap);
  late Map<int, double> workloadMap;
  @override
  State<StatefulWidget> createState() => WorkloadChartState();
}

class WorkloadChartState extends State<WorkloadChart> {
  late List<BarChartGroupData> barGroups;
  late double maxY = 0;

  void processData(Map data) {
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
  }

  @override
  void initState() {
    print('workload: ' + widget.workloadMap.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    processData(widget.workloadMap);
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
                    maxY:
                        maxY, //TODO MAKE THIS DYNAMIC ACCORDING TO THE MAX Y OF DATA
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
                            case 2:
                              return '2';
                            case 4:
                              return '4';

                            case 6:
                              return '6';

                            case 8:
                              return '8';

                            case 10:
                              return '10';

                            case 12:
                              return '12';

                            case 14:
                              return '14';

                            case 16:
                              return '16';

                            case 18:
                              return '18';

                            case 20:
                              return '20';
                            case 22:
                              return '22';
                            case 24:
                              return '24';
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
              Text("Workload (Hrs/Week)"),
            ],
          ),
        ),
      ),
    );
  }
}
