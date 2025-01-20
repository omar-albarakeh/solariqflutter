import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ColoredLiquidProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final double width;
  final Widget? center;

  const ColoredLiquidProgressIndicator({
    Key? key,
    required this.value,
    this.height = 100,
    this.width = 150,
    this.center,
  }) : super(key: key);

  Color _getColorForValue(double value) {
    if (value <= 10) {
      return Colors.red;
    } else if (value <= 40) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: LiquidLinearProgressIndicator(
        value: value / 100,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation(_getColorForValue(value)),
        borderRadius: 12,
        direction: Axis.vertical,
        center: center ?? Text(
          '${value.toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}