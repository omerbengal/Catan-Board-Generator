import 'package:catan_board_generator/barGraph/barData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List numberCounter;
  const MyBarGraph({Key? key, required this.numberCounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      oneAmount: numberCounter[0],
      twoAmount: numberCounter[1],
      threeAmount: numberCounter[2],
      fourAmount: numberCounter[3],
      fiveAmount: numberCounter[4],
      sixAmount: numberCounter[5],
      sevenAmount: numberCounter[6],
      eightAmount: numberCounter[7],
      nineAmount: numberCounter[8],
      tenAmount: numberCounter[9],
      elevenAmount: numberCounter[10],
      twelveAmount: numberCounter[11],
    );
    myBarData.intializeBarData();

    return SizedBox(
      height: 200,
      width: 300,
      child: BarChart(
        BarChartData(
          maxY: 30,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: myBarData.barData
              .map((data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                          toY: data.y.toDouble(),
                          color: Colors.grey[800],
                          width: 15,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 30,
                            color: Colors.grey[200],
                          )),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
