import 'package:catan_board_generator/barGraph/barData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List numberCounter;
  const MyBarGraph({Key? key, required this.numberCounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      twoAmount: numberCounter[0],
      threeAmount: numberCounter[1],
      fourAmount: numberCounter[2],
      fiveAmount: numberCounter[3],
      sixAmount: numberCounter[4],
      sevenAmount: numberCounter[5],
      eightAmount: numberCounter[6],
      nineAmount: numberCounter[7],
      tenAmount: numberCounter[8],
      elevenAmount: numberCounter[9],
      twelveAmount: numberCounter[10],
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
