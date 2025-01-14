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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
