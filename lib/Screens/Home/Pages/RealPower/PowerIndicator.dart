import 'package:flutter/material.dart';

class PowerIndicator extends StatelessWidget {
  final double availablePower;
  final double totalConsumption;
  final double maxPower;

  const PowerIndicator({
    Key? key,
    required this.availablePower,
    required this.totalConsumption,
    required this.maxPower,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCircularIndicator(1.0, Colors.grey.shade300, 12),
        _buildCircularIndicator(totalConsumption / maxPower, Colors.red, 12),
        _buildCircularIndicator(availablePower / maxPower, Colors.green, 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flash_on, size: 30, color: Colors.yellow),
            const SizedBox(height: 5),
            Text(
              '${availablePower.toStringAsFixed(0)} W',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '${totalConsumption.toStringAsFixed(0)} W Consumed',
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularIndicator(double value, Color color, double strokeWidth) {
    return SizedBox(
      width: 150,
      height: 150,
      child: CircularProgressIndicator(
        value: value.clamp(0.0, 1.0),
        strokeWidth: strokeWidth,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}