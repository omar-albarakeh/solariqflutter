import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final Map<String, dynamic> currentWeather;
  final double maxTemp;
  final double minTemp;
  final double maxPowerOutput;
  final double minPowerOutput;
  final Widget cloudIcon;

  const CurrentWeatherWidget({
    Key? key,
    required this.currentWeather,
    required this.maxTemp,
    required this.minTemp,
    required this.maxPowerOutput,
    required this.minPowerOutput,
    required this.cloudIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: cloudIcon),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Max Temp: ${maxTemp.toStringAsFixed(1)} °C'),
              Text('Min Temp: ${minTemp.toStringAsFixed(1)} °C'),
              Text('Condition: ${currentWeather['weatherMain'] ?? 'N/A'}'),
              Text('Sunrise: ${currentWeather['sunrise']}'),
              Text('Sunset: ${currentWeather['sunset']}'),
              Text('Max Power Output: ${maxPowerOutput.toStringAsFixed(2)} kW'),
              Text('Min Power Output: ${minPowerOutput.toStringAsFixed(2)} kW'),
            ],
          ),
        ),
      ],
    );
  }
}
