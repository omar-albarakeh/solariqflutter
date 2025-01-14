import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
