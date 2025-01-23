import 'package:flutter/material.dart';
import 'package:solariqflutter/Screens/Home/weather/poweroutput.dart';
import 'package:solariqflutter/Screens/Home/weather/weatheranimation.dart';
import 'package:solariqflutter/Screens/Home/weather/weatherdatamodel.dart';

class WeatherUIComponents {
  static Widget buildSectionTitle(String title, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        if (icon != null) const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget buildCurrentWeatherAndPowerOutput(
      Map<String, dynamic> currentWeather,
      List<Map<String, dynamic>> fiveDayForecast,
      List<Map<String, dynamic>> solarRadiationData,
      WeatherDataModel weatherDataModel,
      PowerOutputCalculator powerOutputCalculator,
      ) {
    double maxTemp = double.negativeInfinity;
    double minTemp = double.infinity;

    for (var forecast in fiveDayForecast) {
      double temperatureInCelsius =
          double.parse(forecast['temperature']) - 273.15;
      if (temperatureInCelsius > maxTemp) maxTemp = temperatureInCelsius;
      if (temperatureInCelsius < minTemp) minTemp = temperatureInCelsius;
    }

    minTemp = minTemp <= -50 ? -50 : minTemp;

    double maxPowerOutput = double.negativeInfinity;
    double minPowerOutput = double.infinity;

    for (var radiation in solarRadiationData) {
      double radiationValue = radiation['radiation'];
      double powerOutput =
      powerOutputCalculator.calculatePowerOutput(radiationValue);

      if (powerOutput > maxPowerOutput) maxPowerOutput = powerOutput;
      if (powerOutput < minPowerOutput) minPowerOutput = powerOutput;
    }

    minPowerOutput = minPowerOutput <= 0 ? 0.1 : minPowerOutput;

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: WeatherAnimationManager.getCloudIcon(
                  currentWeather['clouds'] ?? ''),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.zero, 
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSectionTitle('Current Weather'),
                      const Icon(
                        Icons.thermostat,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                                size: 22,
                              ),
                              Text(
                                'Max Temp: ${maxTemp.toStringAsFixed(1)} °C',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.blue,
                                size: 22,
                              ),
                              Text(
                                'Min Temp: ${minTemp.toStringAsFixed(1)} °C',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.cloud,
                                color: Colors.grey,
                                size: 22,
                              ),
                              Text(
                                'Condition: ${currentWeather['weatherMain'] ?? 'N/A'}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.sunny,
                                color: Colors.yellow,
                                size: 22,
                              ),
                              Text(
                                'Sunrise: ${weatherDataModel.formatTimestamp(currentWeather['sunrise'])}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.shield_moon,
                                color: Colors.blue,
                                size: 22,
                              ),
                              Text(
                                'Sunset: ${weatherDataModel.formatTimestamp(currentWeather['sunset'])}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  buildSectionTitle('Power Output Data'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.power,
                        color: Colors.black,
                        size: 22,
                      ),
                      Text(
                        'Max Power Output: ${maxPowerOutput.toStringAsFixed(2)} kW',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.power,
                        color: Colors.black,
                        size: 22,
                      ),
                      Text(
                        'Min Power Output: ${minPowerOutput.toStringAsFixed(2)} kW',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildDailyForecastAtNoon(
      List<Map<String, dynamic>> fiveDayForecast,
      List<Map<String, dynamic>> solarRadiationData,
      PowerOutputCalculator powerOutputCalculator,
      ) {
    final now = DateTime.now();


    final dailyNoonForecast = fiveDayForecast.where((forecast) {
      final forecastTime = DateTime.parse(forecast['time']);
      return forecastTime.hour == 12 && forecastTime.isAfter(now);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B273D).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle('Daily Noon Forecast'),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dailyNoonForecast.length,
            itemBuilder: (context, index) {
              final forecast = dailyNoonForecast[index];
              final forecastTime = DateTime.parse(forecast['time']);
              final temperatureInCelsius =
                  double.parse(forecast['temperature']) - 273.15;
              final cloudCondition = forecast['cloudsValue'] ?? '';
              final correspondingRadiationData =
              solarRadiationData.firstWhere(
                    (radiation) {
                  final radiationTime = DateTime.parse(radiation['time']);
                  return radiationTime.year == forecastTime.year &&
                      radiationTime.month == forecastTime.month &&
                      radiationTime.day == forecastTime.day &&
                      radiationTime.hour == 12;
                },
                orElse: () => {'radiation': 0.0},
              );
              final radiationValue = correspondingRadiationData['radiation'];
              final powerOutput =
              powerOutputCalculator.calculatePowerOutput(radiationValue);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  color: Colors.white.withOpacity(0.7),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: WeatherAnimationManager.getCloudIcon(
                              cloudCondition),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: ${forecastTime.toIso8601String().substring(0, 10)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Temperature: ${temperatureInCelsius.toStringAsFixed(1)} °C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Clouds: ${forecast['cloudsValue']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Power Output: ${powerOutput.toStringAsFixed(2)} kW',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }}
