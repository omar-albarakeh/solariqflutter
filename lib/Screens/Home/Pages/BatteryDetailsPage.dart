import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  final List<FlSpot> _voltageDataPoints = [];
  final List<FlSpot> _currentDataPoints = [];
  final List<FlSpot> _socDataPoints = [];
  late WebSocketChannel _channel;
  String _batteryComment = "No data received yet.";
  int _cycleCount = 0;
  double _temperature = 25.0;
  double _internalResistance = 0.05;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.43.60:81'),
    );

    _channel.stream.listen(
          (data) {
        try {
          final jsonData = json.decode(data);
          final double voltage = jsonData['voltage'];
          final double current = jsonData['current'];
          final double soc = jsonData['soc'];

          setState(() {
            _voltageDataPoints.add(FlSpot(_voltageDataPoints.length.toDouble(), voltage));
            _currentDataPoints.add(FlSpot(_currentDataPoints.length.toDouble(), current));
            _socDataPoints.add(FlSpot(_socDataPoints.length.toDouble(), soc));

            if (_voltageDataPoints.length > 100) {
              _voltageDataPoints.removeAt(0);
              _currentDataPoints.removeAt(0);
              _socDataPoints.removeAt(0);
            }

            _batteryComment = _getBatteryComment(voltage, current, soc);

            _cycleCount++;
            _temperature = 25.0 + (current / 10);
            _internalResistance = 0.05 + (_cycleCount * 0.001);
          });
        } catch (e) {
          print("Error parsing JSON: $e");
        }
      },
      onError: (error) {
        print("WebSocket error: $error");
      },
      onDone: () {
        print("WebSocket connection closed");
      },
    );
  }

  String _getBatteryComment(double voltage, double current, double soc) {
    if (voltage < 20.0) {
      return "Warning: Low voltage detected. Charge the battery immediately.";
    } else if (current > 15.0) {
      return "Warning: High current detected. Check for potential overload.";
    } else if (soc < 20.0) {
      return "Warning: Low State of Charge (SoC). Consider recharging the battery.";
    } else {
      return "Battery is operating within normal parameters.";
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'Battery Life Tracking',
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
           color: Colors.black26,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Battery Health Metrics',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _buildMetricText('Cycle Count: $_cycleCount'),
                      _buildMetricText('Temperature: ${_temperature.toStringAsFixed(1)}°C'),
                      _buildMetricText('Internal Resistance: ${_internalResistance.toStringAsFixed(3)} Ω'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  // Chart
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}',
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                              reservedSize: 40,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: const Color(0xff37434d), width: 1),
                        ),
                        minX: 0,
                        maxX: _voltageDataPoints.length > 0 ? _voltageDataPoints.length.toDouble() : 100,
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: _voltageDataPoints,
                            isCurved: true,
                            color: Colors.blue,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _currentDataPoints,
                            isCurved: true,
                            color: Colors.red,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _socDataPoints,
                            isCurved: true,
                            color: Colors.green,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 8,
                      children: [

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('Voltage'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('Current'),
                          ],
                        ),
                        // SoC Legend
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('SoC'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _batteryComment,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _batteryComment.startsWith("Warning") ? Colors.red : Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.4),
            offset: Offset(1, 1),
          ),
        ],
      ),
    );
  }
}