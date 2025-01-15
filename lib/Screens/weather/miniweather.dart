import 'package:flutter/material.dart';
import 'package:solariqflutter/Screens/weather/weatheranimation.dart';
import 'package:solariqflutter/Screens/weather/weatherprediction.dart';
import '../../Widgets/Home/homewidgets/ReusableCard.dart';

Widget miniWeather({
  required double maxTemp,
  required double maxPowerOutput,
  required String cloudCondition,
  required BuildContext context,
  double? width,
  double? height,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherPrediction1(),
        ),
      );
    },
    child: SizedBox(
      width: width, // Set the width
      height: height, // Set the height
      child: ReusableCard(
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: WeatherAnimationManager.getCloudIcon(cloudCondition),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Max Temperature',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${maxTemp.toStringAsFixed(1)} °C',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Max Power Output',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.power,
                          color: Colors.black,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${maxPowerOutput.toStringAsFixed(2)} kW',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}