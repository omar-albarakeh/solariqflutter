import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pie Chart Example')),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 30,
                title: '30%',
                color: Colors.blue,
                radius: 50,
                titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              PieChartSectionData(
                value: 20,
                title: '20%',
                color: Colors.red,
                radius: 50,
                titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              PieChartSectionData(
                value: 50,
                title: '50%',
                color: Colors.green,
                radius: 50,
                titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}