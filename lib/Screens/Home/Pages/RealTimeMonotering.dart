import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealTimeMonotering extends StatefulWidget {
  const RealTimeMonotering({super.key});

  @override
  State<RealTimeMonotering> createState() => _lifeMonitoringState();
}

class _lifeMonitoringState extends State<RealTimeMonotering> {

  static const double maxPower = 1500;
  double availablePower = 0;

  double _calculatePowerDifference() {
    return availablePower - _calculateTotalPowerConsumption();
  }

  late final WebSocketChannel channel;
  String connectionStatus = "Disconnected";


  final List<Map<String, dynamic>> devices = [
    {"name": "AC", "power": 400, "isOn": false},
    {"name": "Fan", "power": 100, "isOn": false},
    {"name": "TV", "power": 200, "isOn": false},
    {"name": "Heater", "power": 500, "isOn": false},
    {"name": "Laptop", "power": 150, "isOn": false},
    {"name": "Refrigerator", "power": 300, "isOn": false},
  ];

  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.0.100:81'),
      );
      connectionStatus = "Connected";

      channel.stream.listen(
            (data) {
          try {
            final parsedData = jsonDecode(data);
            _updateAvailablePower(parsedData);
          } catch (e) {
            debugPrint('Error parsing WebSocket data: $e');
          }
        },
        onDone: () {
          setState(() {
            connectionStatus = "Disconnected";
          });
        },
        onError: (error) {
          setState(() {
            connectionStatus = "Error: $error";
          });
        },
      );
    } catch (e) {
      setState(() {
        connectionStatus = "Error connecting: $e";
      });
    }
  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
  void _updateAvailablePower(Map<String, dynamic> data) {
    setState(() {
      availablePower = (data['potentio'] as num).toDouble() * 15;
    });
    _checkPowerStatus();
  }

  void _showPowerExceededDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Power Exceeded"),
          content: Text(
              "Turning on '$deviceName' exceeds available power. It has been turned off."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


}

