import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import '../Widgets/Home/homewidgets/ReusableCard.dart';
class CurrentWeatherCard extends StatelessWidget {
  final Map<String, dynamic> currentWeather;
  final double maxTemp;
  final double minTemp;
  final VoidCallback? onTap;

  const CurrentWeatherCard({
    Key? key,
    required this.currentWeather,
    required this.maxTemp,
    required this.minTemp,
    this.onTap,
  }) : super(key: key);

  Widget getCloudIcon(String cloudSituation) {
    switch (cloudSituation.toLowerCase()) {
      case 'clear sky':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'few clouds':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'scattered clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'broken clouds':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'overcast clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'light rain':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'moderate rain':
        return WeatherScene.showerSleet.sceneWidget;
      case 'heavy intensity rain':
        return WeatherScene.stormy.sceneWidget;
      default:
        return WeatherScene.snowfall.sceneWidget;
    }
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return 'N/A';
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Weather'),
              Icon(
                Icons.thermostat,
                color: Colors.orange,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: getCloudIcon(currentWeather['clouds'] ?? ''),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max Temp: ${maxTemp.toStringAsFixed(1)} °C',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Min Temp: ${minTemp.toStringAsFixed(1)} °C',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Condition: ${currentWeather['weatherMain'] ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sunrise: ${_formatTimestamp(currentWeather['sunrise'])}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sunset: ${_formatTimestamp(currentWeather['sunset'])}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
