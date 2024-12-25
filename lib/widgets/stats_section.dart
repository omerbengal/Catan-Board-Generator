import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';

class StatsSection extends StatelessWidget {
  final String sessionCode;

  const StatsSection({
    Key? key,
    required this.sessionCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child(sessionCode).onValue,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        if (!snapshot.hasData || snapshot.data?.snapshot?.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        Map<String, dynamic> data = Map<String, dynamic>.from(
            json.decode(snapshot.data.snapshot.value));

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              barGroups: [
                for (int i = 2; i <= 12; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: (data[i.toString()] ?? 0).toDouble(),
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) =>
                        Text(value.toInt().toString()),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
